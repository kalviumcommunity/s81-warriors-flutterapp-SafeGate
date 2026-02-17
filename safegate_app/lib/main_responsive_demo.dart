import 'package:flutter/material.dart';
import 'screens/responsive_home.dart';

/// Standalone demo to showcase the responsive layout
/// Run this file to test the responsive design without Firebase dependencies
void main() {
  runApp(const ResponsiveLayoutDemo());
}

class ResponsiveLayoutDemo extends StatelessWidget {
  const ResponsiveLayoutDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeGate - Responsive Layout Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const ResponsiveHome(),
    );
  }
}
