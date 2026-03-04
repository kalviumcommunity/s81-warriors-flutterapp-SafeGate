import 'package:flutter/material.dart';

/// A demo showcasing setState() for local state management in Flutter.
/// 
/// This example demonstrates:
/// - Declaring a StatefulWidget
/// - Using local variables to store state (_counter)
/// - Updating the UI dynamically using setState()
/// - Conditional UI updates based on state values
class StateManagementDemo extends StatefulWidget {
  const StateManagementDemo({super.key});

  @override
  State<StateManagementDemo> createState() => _StateManagementDemoState();
}

class _StateManagementDemoState extends State<StateManagementDemo> {
  int _counter = 0;

  /// Increments the counter and triggers a UI rebuild
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    debugPrint('Counter incremented to $_counter');
  }

  /// Decrements the counter (only if > 0) and triggers a UI rebuild
  void _decrementCounter() {
    setState(() {
      if (_counter > 0) _counter--;
    });
    debugPrint('Counter decremented to $_counter');
  }

  /// Resets the counter to zero
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
    debugPrint('Counter reset to 0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Management Demo'),
        backgroundColor: _counter >= 10 ? Colors.green : Colors.blue,
        actions: [
          IconButton(
            onPressed: _resetCounter,
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset Counter',
          ),
        ],
      ),
      // Conditional background color based on counter value
      body: Container(
        color: _getBackgroundColor(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Status indicator
              _buildStatusIndicator(),
              const SizedBox(height: 20),
              
              // Counter display
              const Text(
                'Button pressed:',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '$_counter times',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              
              // Threshold message
              Text(
                _getThresholdMessage(),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 30),
              
              // Control buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _decrementCounter,
                    icon: const Icon(Icons.remove),
                    label: const Text('Decrement'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: _incrementCounter,
                    icon: const Icon(Icons.add),
                    label: const Text('Increment'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[400],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              
              // Info card about setState
              _buildInfoCard(),
            ],
          ),
        ),
      ),
    );
  }

  /// Returns background color based on counter thresholds
  Color _getBackgroundColor() {
    if (_counter >= 10) {
      return Colors.greenAccent.withValues(alpha: 0.3);
    } else if (_counter >= 5) {
      return Colors.yellowAccent.withValues(alpha: 0.3);
    } else {
      return Colors.white;
    }
  }

  /// Returns a message based on counter thresholds
  String _getThresholdMessage() {
    if (_counter >= 10) {
      return '🎉 Great job! You reached 10+';
    } else if (_counter >= 5) {
      return '⭐ Halfway there! Keep going...';
    } else if (_counter > 0) {
      return 'Keep tapping to reach 5!';
    } else {
      return 'Tap Increment to start counting';
    }
  }

  /// Builds a visual status indicator
  Widget _buildStatusIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(10, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index < _counter ? Colors.blue : Colors.grey[300],
            border: Border.all(color: Colors.grey),
          ),
        );
      }),
    );
  }

  /// Builds an info card explaining setState
  Widget _buildInfoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: const Column(
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                'How setState() Works',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'When you tap a button, setState() is called, which tells '
            'Flutter to rebuild only the affected parts of this widget. '
            'Notice how the counter, background color, and status indicator '
            'all update together!',
            style: TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
