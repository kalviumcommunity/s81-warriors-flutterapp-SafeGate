import 'package:flutter/material.dart';

class ScrollableViewsScreen extends StatelessWidget {
  const ScrollableViewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scrollable Views')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 20,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) => Card(
          child: ListTile(
            leading: const Icon(Icons.view_stream_rounded),
            title: Text('Scrollable item ${index + 1}'),
          ),
        ),
      ),
    );
  }
}