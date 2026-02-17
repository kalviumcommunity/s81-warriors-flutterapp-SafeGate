import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeGate App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool _isWelcomed = false;

  void _toggleWelcome() {
    setState(() {
      _isWelcomed = !_isWelcomed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to SafeGate'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to SafeGate App!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Icon(
              _isWelcomed ? Icons.check_circle : Icons.home,
              size: 100,
              color: _isWelcomed ? Colors.green : Colors.blue,
            ),
            const SizedBox(height: 20),
            Text(
              _isWelcomed ? 'You are welcomed!' : 'Tap the button to get started.',
              style: TextStyle(fontSize: 18, color: _isWelcomed ? Colors.green : Colors.black),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _toggleWelcome,
              child: Text(_isWelcomed ? 'Reset' : 'Welcome Me'),
            ),
          ],
        ),
      ),
    );
  }
}
