import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection('tasks');

  // Add task with optional image URL
  Future<void> addTask(String title, [String? imageUrl]) {
    return tasks.add({
      'title': title,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.now(),
      'isCompleted': false,
    });
  }

  // Get tasks stream
  Stream<QuerySnapshot> getTasks() {
    return tasks.orderBy('createdAt', descending: true).snapshots();
  }

  // Update task completion
  Future<void> toggleTaskCompletion(String docId, bool currentStatus) {
    return tasks.doc(docId).update({
      'isCompleted': !currentStatus,
    });
  }

  // Delete task
  Future<void> deleteTask(String docId) {
    return tasks.doc(docId).delete();
  }
}
