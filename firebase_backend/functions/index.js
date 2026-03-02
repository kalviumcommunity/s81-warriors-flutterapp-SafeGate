const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

/**
 * Triggered whenever a document in the `users` collection is Created or Updated.
 * This reads the user's `role` and `society_id` and mints it into their
 * Firebase Authentication Custom Claims for secure route and data protection.
 */
exports.syncUserRoleToCustomClaims = functions.firestore
  .document("users/{userId}")
  .onWrite(async (change, context) => {
    // If the document is deleted, we might want to revoke claims or disable the user
    if (!change.after.exists) {
      console.log(`User document ${context.params.userId} was deleted.`);
      // You can completely revoke sessions here if needed:
      // await admin.auth().revokeRefreshTokens(context.params.userId);
      return null;
    }

    const newUserData = change.after.data();
    const oldUserData = change.before.exists ? change.before.data() : null;

    // Check if role or society_id actually changed to avoid infinite loops / redundant calls
    if (
      oldUserData &&
      oldUserData.role === newUserData.role &&
      oldUserData.society_id === newUserData.society_id
    ) {
      console.log(`No RBAC role changes for ${context.params.userId}. Skipping.`);
      return null;
    }

    const { role, society_id } = newUserData;

    console.log(`Assigning Role [${role}] and Society [${society_id || 'Global'}] to User: ${context.params.userId}`);

    try {
      // Set the custom claims on the Firebase Auth Token
      await admin.auth().setCustomUserClaims(context.params.userId, {
        role: role || 'resident',
        society_id: society_id || null,
        is_active: true
      });

      console.log(`Successfully synced claims for ${context.params.userId}`);
      return { success: true };
    } catch (error) {
      console.error(`Failed to assign custom claims to ${context.params.userId}:`, error);
      return { error: error.message };
    }
  });

/**
 * Direct Callable function to Elevate a user (Must be called by an existing admin)
 * This prevents users from simply editing their own role via compromised endpoints.
 */
exports.elevateUserRole = functions.https.onCall(async (data, context) => {
  // 1. Check if the caller is authenticated
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'The function must be called while authenticated.'
    );
  }

  // 2. Validate Caller Claims (Only super_admin or admin can elevate)
  const callerRole = context.auth.token.role;
  if (callerRole !== 'super_admin' && callerRole !== 'admin') {
    throw new functions.https.HttpsError(
      'permission-denied',
      'Only administrators can elevate roles.'
    );
  }

  const targetUid = data.uid;
  const newRole = data.role;
  const targetSociety = data.society_id;

  if (!targetUid || !newRole) {
    throw new functions.https.HttpsError('invalid-argument', 'Missing uid or role.');
  }

  try {
    // 3. Update the Firestore User Database Record (which will auto-trigger syncUserRoleToCustomClaims)
    await admin.firestore().collection('users').doc(targetUid).set({
      role: newRole,
      society_id: targetSociety || null,
      updatedAt: admin.firestore.FieldValue.serverTimestamp()
    }, { merge: true });

    return { message: `User ${targetUid} elevated to ${newRole} successfully.` };
  } catch (err) {
    console.error(err);
    throw new functions.https.HttpsError('unknown', err.message);
  }
});
