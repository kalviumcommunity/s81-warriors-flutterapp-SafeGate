import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'services/auth_service.dart';
import 'screens/welcome_page.dart';
import 'screens/dashboard_page.dart';
import 'screens/widget_tree_demo.dart';
import 'screens/stateless_stateful_demo.dart';
import 'screens/devtools_demo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SafeGate App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const DevToolsDemo(),  // Changed to DevTools Demo for demonstration
      routes: {
        '/login': (context) => const WelcomePage(),
        '/dashboard': (context) => const DashboardPage(),
        '/devtools': (context) => const DevToolsDemo(),
        '/stateless-stateful': (context) => const StatelessStatefulDemo(),
      },
    );
  }
}
