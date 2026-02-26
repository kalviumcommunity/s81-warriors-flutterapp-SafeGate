import 'package:flutter/material.dart';

class WidgetTreeDemo extends StatefulWidget {
  const WidgetTreeDemo({super.key});

  @override
  _WidgetTreeDemoState createState() => _WidgetTreeDemoState();
}

class _WidgetTreeDemoState extends State<WidgetTreeDemo> {
  int count = 0;
  Color backgroundColor = Colors.white;

  void increment() {
    setState(() {
      count++;
    });
  }

  void changeColor() {
    setState(() {
      backgroundColor = backgroundColor == Colors.white ? Colors.lightBlue : Colors.white;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Tree Demo'),
      ),
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Count:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '$count',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: increment,
              child: const Text('Increment'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: changeColor,
              child: const Text('Change Background Color'),
            ),
          ],
        ),
      ),
    );
  }
}