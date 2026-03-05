import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'login_page.dart';


class AnimationsDemoScreen extends StatefulWidget {
  const AnimationsDemoScreen({super.key});

  @override
  State<AnimationsDemoScreen> createState() => _AnimationsDemoScreenState();
}

class _AnimationsDemoScreenState extends State<AnimationsDemoScreen>
    with SingleTickerProviderStateMixin {
  bool _isToggled = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Animations & Transitions'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('1. Implicit Animation: AnimatedContainer'),
            const SizedBox(height: 16),
            Center(
              child: GestureDetector(
                onTap: () => setState(() => _isToggled = !_isToggled),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutBack,
                  width: _isToggled ? 200 : 120,
                  height: _isToggled ? 200 : 120,
                  decoration: BoxDecoration(
                    color: _isToggled ? primaryColor : Colors.grey[800],
                    borderRadius: BorderRadius.circular(_isToggled ? 100 : 20),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(_isToggled ? 0.4 : 0),
                        blurRadius: 20,
                        spreadRadius: 5,
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      _isToggled ? 'Teal Circle' : 'Gray Box',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _isToggled ? Colors.black : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Center(child: Text('Tap the box to animate', style: TextStyle(color: Colors.grey))),

            const SizedBox(height: 48),

            _buildSectionTitle('2. Implicit Animation: AnimatedOpacity'),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  AnimatedOpacity(
                    opacity: _isToggled ? 1.0 : 0.2,
                    duration: const Duration(milliseconds: 800),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.security, size: 64, color: primaryColor),
                          const SizedBox(height: 8),
                          const Text('SafeGate Security', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => setState(() => _isToggled = !_isToggled),
                    child: Text(_isToggled ? 'Fade Out' : 'Fade In'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 48),

            _buildSectionTitle('3. Explicit Animation: RotationTransition'),
            const SizedBox(height: 16),
            Center(
              child: RotationTransition(
                turns: _controller,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: primaryColor, width: 2),
                    gradient: SweepGradient(
                      colors: [primaryColor, Colors.transparent, primaryColor],
                      stops: const [0, 0.5, 1],
                    ),
                  ),
                  child: Icon(Icons.sync, size: 48, color: primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Center(child: Text('Continuous rotation using AnimationController', style: TextStyle(color: Colors.grey))),

            const SizedBox(height: 48),

            _buildSectionTitle('4. Page Transition Example'),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Go to Login (Slide Transition)'),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOutQuart;
                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
