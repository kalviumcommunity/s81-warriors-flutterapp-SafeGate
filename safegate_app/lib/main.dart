import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:safegate_app/services/firebase_status.dart';
import 'screens/welcome_page.dart';
import 'screens/dashboard_page.dart';
import 'screens/stateless_stateful_demo.dart';
import 'screens/devtools_demo.dart';
import 'screens/home_screen.dart';
import 'screens/second_screen.dart';
import 'screens/login_page.dart';
import 'screens/responsive_layout.dart';
import 'screens/scrollable_views.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    firebaseAvailable = true;
  } catch (e, st) {
    // Firebase options may be missing on web (firebase_options.dart not generated).
    // Log the error and continue so the app can render for development/demo purposes.
    // Run `flutterfire configure` to generate `lib/firebase_options.dart` and
    // initialize with `DefaultFirebaseOptions.currentPlatform` for a proper fix.
    // ignore: avoid_print
    print('Firebase.initializeApp() failed: $e\n$st');
    firebaseAvailable = false;
  }
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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0D7377),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D7377),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF14A085),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/second': (context) => const SecondScreen(),
        '/login': (context) => const LoginPage(),
        '/welcome': (context) => const WelcomePage(),
        '/dashboard': (context) => const DashboardPage(),
        '/devtools': (context) => const DevToolsDemo(),
        '/stateless-stateful': (context) => const StatelessStatefulDemo(),
        '/responsive': (context) => const ResponsiveLayout(),
        '/scrollable': (context) => const ScrollableViews(),
      },
    );
  }
}
