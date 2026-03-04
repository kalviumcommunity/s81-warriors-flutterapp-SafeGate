import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:safegate_app/services/firebase_status.dart';
import 'screens/auth_wrapper.dart';
import 'screens/home_screen.dart';
import 'screens/dashboard_page.dart';
import 'screens/login_page.dart';
import 'screens/responsive_layout.dart';
import 'screens/user_input_form.dart';
import 'screens/scrollable_views.dart';
import 'screens/role_selection_screen.dart';
import 'screens/guard_dashboard.dart';
import 'screens/admin_dashboard.dart';
import 'screens/super_admin_dashboard.dart';

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
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00BFA5), // Premium Teal accent
          secondary: Color(0xFF00897B), // Dark Teal
          surface: Color(0xFF1E1E1E),
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A1A1A),
          foregroundColor: Color(0xFF00BFA5),
          elevation: 0,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00BFA5),
            foregroundColor: Colors.black87,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/user-input': (context) => const UserInputForm(),
        '/second': (context) => const SecondScreen(),
        '/responsive': (context) => const ResponsiveLayoutScreen(),
        '/scrollable': (context) => const ScrollableViewsScreen(),

        '/': (context) => const AuthWrapper(),
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/roles': (context) => const RoleSelectionScreen(),
        '/guard': (context) => const GuardDashboard(),
        '/admin': (context) => const AdminDashboard(),
        '/superadmin': (context) => const SuperAdminDashboard(),
      },
    );
  }
}
