import 'package:flutter/material.dart';

/// DevTools Demo Page
/// This page demonstrates Flutter's Hot Reload, Debug Console, and DevTools features.
/// 
/// HOW TO USE THIS DEMO:
/// 1. Run the app: flutter run
/// 2. Try Hot Reload: Change colors/text below and save (press 'r' in terminal)
/// 3. Watch Debug Console: See debugPrint() messages in real-time
/// 4. Open DevTools: Run 'flutter pub global run devtools' in another terminal

class DevToolsDemo extends StatefulWidget {
  const DevToolsDemo({super.key});

  @override
  State<DevToolsDemo> createState() => _DevToolsDemoState();
}

class _DevToolsDemoState extends State<DevToolsDemo> {
  int _tapCount = 0;
  
  // HOT RELOAD DEMO: Try changing these values and saving!
  // The app will update instantly without losing the _tapCount state.
  static const String appTitle = 'Hot Reload Demo';  // Try: 'Welcome to Hot Reload!'
  static const Color primaryColor = Color(0xFF0D7377);   // Try: Colors.teal, Colors.purple
  static const double cardElevation = 4.0;           // Try: 8.0, 12.0
  
  @override
  void initState() {
    super.initState();
    debugPrint('🚀 DevToolsDemo initialized');
    debugPrint('   Widget lifecycle: initState() called');
  }

  @override
  void didUpdateWidget(covariant DevToolsDemo oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('🔄 Hot Reload detected! didUpdateWidget() triggered');
  }

  void _incrementTap() {
    setState(() {
      _tapCount++;
      debugPrint('👆 Tap count updated to: $_tapCount');
      debugPrint('   setState() called - UI will rebuild');
      debugPrint('   Timestamp: ${DateTime.now()}');
    });
  }

  void _resetTap() {
    setState(() {
      _tapCount = 0;
      debugPrint('🔄 Reset! Tap count cleared');
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('🏗️ Building DevToolsDemo widget...');
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetTap,
            tooltip: 'Reset Counter',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hot Reload Section
            _buildSectionCard(
              title: '🔥 Hot Reload Demo',
              description: 'Try changing colors or text in the code and save! '
                  'Your changes appear instantly without losing app state.',
              icon: Icons.flash_on,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),

            // Interactive Counter Card
            _buildCounterCard(),
            const SizedBox(height: 16),

            // Debug Console Section
            _buildSectionCard(
              title: '🖥️ Debug Console',
              description: 'Tap the buttons and watch the Debug Console! '
                  'All interactions are logged with debugPrint().',
              icon: Icons.terminal,
              color: Colors.green,
            ),
            const SizedBox(height: 16),

            // DevTools Section
            _buildDevToolsCard(),
            const SizedBox(height: 16),

            // Instructions Card
            _buildInstructionsCard(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _incrementTap,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.touch_app),
        label: const Text('Tap Me!'),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: cardElevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withAlpha(26),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterCard() {
    return Card(
      elevation: cardElevation,
      color: primaryColor.withAlpha(13),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: primaryColor, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.analytics, color: primaryColor),
                SizedBox(width: 8),
                Text(
                  'State Preservation Test',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '$_tapCount',
              style: const TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const Text(
              'taps',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.withAlpha(26),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: Colors.amber),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Hot Reload preserves this count! '
                      'Change the code and save - the number stays.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDevToolsCard() {
    return Card(
      elevation: cardElevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.developer_mode, color: Colors.blue, size: 28),
                SizedBox(width: 8),
                Text(
                  '🛠️ Flutter DevTools',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildDevToolFeature(
              '📊 Widget Inspector',
              'Explore the widget tree visually',
              Colors.purple,
            ),
            _buildDevToolFeature(
              '⚡ Performance',
              'Monitor frame rendering and jank',
              Colors.red,
            ),
            _buildDevToolFeature(
              '💾 Memory',
              'Track memory usage and leaks',
              Colors.teal,
            ),
            _buildDevToolFeature(
              '🌐 Network',
              'Debug API calls and responses',
              Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDevToolFeature(String title, String description, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionsCard() {
    return Card(
      elevation: cardElevation,
      color: Colors.blue.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  'Quick Start Guide',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildInstruction('1', 'Run app: flutter run'),
            _buildInstruction('2', 'Hot Reload: Press \'r\' in terminal'),
            _buildInstruction('3', 'Hot Restart: Press \'R\' in terminal'),
            _buildInstruction('4', 'DevTools: flutter pub global run devtools'),
          ],
        ),
      ),
    );
  }

  Widget _buildInstruction(String number, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
