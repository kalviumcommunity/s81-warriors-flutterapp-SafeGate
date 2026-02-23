import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../services/storage_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();
  final FirestoreService _firestore = FirestoreService();
  final StorageService _storage = StorageService();
  final TextEditingController _taskController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  
  File? _imageFile;
  bool _isUploading = false;

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _addTask() async {
    if (_taskController.text.isEmpty) return;
    
    setState(() => _isUploading = true);
    
    String? imageUrl;
    if (_imageFile != null) {
      imageUrl = await _storage.uploadFile(_imageFile!);
    }

    await _firestore.addTask(_taskController.text, imageUrl);
    
    _taskController.clear();
    setState(() {
      _imageFile = null;
      _isUploading = false;
    });
    
    if (mounted) Navigator.pop(context);
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text("Add New Task"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(hintText: "Enter task name"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        setDialogState(() {
                          _imageFile = File(pickedFile.path);
                        });
                      }
                    },
                    icon: const Icon(Icons.image),
                    label: Text(_imageFile == null ? "Pick Image" : "Image Selected"),
                  ),
                   if (_isUploading) const LinearProgressIndicator(),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _taskController.clear();
                    _imageFile = null;
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: _isUploading ? null : () async {
                    if (_taskController.text.isEmpty) return;
                    
                    setDialogState(() => _isUploading = true);
                    
                    String? imageUrl;
                    if (_imageFile != null) {
                      imageUrl = await _storage.uploadFile(_imageFile!);
                    }

                    await _firestore.addTask(_taskController.text, imageUrl);
                    
                    _taskController.clear();
                    _imageFile = null;
                    if (mounted) Navigator.pop(context);
                  },
                  child: const Text("Add"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Syncly Tasks"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _auth.signOut(),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Center(child: Text("Error loading tasks"));
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final tasks = snapshot.data!.docs;
          if (tasks.isEmpty) return const Center(child: Text("No tasks yet. Add one!"));

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              final data = task.data() as Map<String, dynamic>;
              final bool isCompleted = data['isCompleted'] ?? false;
              final String? imageUrl = data['imageUrl'];

              return Card(
                child: ListTile(
                  leading: Checkbox(
                    value: isCompleted,
                    onChanged: (val) => _firestore.toggleTaskCompletion(task.id, isCompleted),
                  ),
                  title: Text(
                    data['title'],
                    style: TextStyle(
                      decoration: isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  subtitle: imageUrl != null 
                    ? Image.network(imageUrl, height: 100, fit: BoxFit.cover) 
                    : null,
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _firestore.deleteTask(task.id),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
