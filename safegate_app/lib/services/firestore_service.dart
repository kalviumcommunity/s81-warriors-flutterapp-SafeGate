import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safegate_app/services/firebase_status.dart';

// Guards Firestore usage when Firebase isn't initialized (e.g., web without
// firebase_options.dart). In that case methods become no-ops or return empty
// streams to avoid throwing during widget build.

class FirestoreService {
  FirebaseFirestore? _db;
  CollectionReference? tasks;

  FirestoreService() {
    if (firebaseAvailable) {
      _db = FirebaseFirestore.instance;
      tasks = _db!.collection('tasks');
    }
  }

  // Add task with optional image URL
  Future<void> addTask(String title, [String? imageUrl]) async {
    if (tasks == null) return;
    await tasks!.add({
      'title': title,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.now(),
      'isCompleted': false,
    });
  }

  // Get tasks stream
  Stream<QuerySnapshot> getTasks() {
    if (tasks == null) return const Stream.empty();
    return tasks!.orderBy('createdAt', descending: true).snapshots();
  }

  // Update task completion
  Future<void> toggleTaskCompletion(String docId, bool currentStatus) async {
    if (tasks == null) return;
    await tasks!.doc(docId).update({
      'isCompleted': !currentStatus,
    });
  }

  // Delete task
  Future<void> deleteTask(String docId) async {
    if (tasks == null) return;
    await tasks!.doc(docId).delete();
  }
}
