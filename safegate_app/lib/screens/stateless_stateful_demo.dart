import 'package:flutter/material.dart';

class StatelessStatefulDemo extends StatelessWidget {
  const StatelessStatefulDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateless vs Stateful Widgets'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. A StatelessWidget for a static title or banner.
            const HeaderBannerWidget(
              title: 'Stateless Widget Example',
              subtitle: 'This widget is static and does not change once built.',
              color: Colors.indigoAccent,
            ),
            const SizedBox(height: 24),

            // 2. A StatefulWidget for an interactive section.
            const InteractiveCounterWidget(),
            const SizedBox(height: 24),

            const HeaderBannerWidget(
              title: 'Color Changer Example',
              subtitle: 'Another demonstration of state management.',
              color: Colors.deepPurpleAccent,
            ),
            const SizedBox(height: 24),

            const InteractiveColorChanger(),
          ],
        ),
      ),
    );
  }
}

/// A StatelessWidget that displays a static header banner.
/// It doesn't store any mutable state and only depends on configuration.
class HeaderBannerWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;

  const HeaderBannerWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

/// A StatefulWidget that manages an interactive counter.
/// It rebuilds its UI dynamically when the count changes.
class InteractiveCounterWidget extends StatefulWidget {
  const InteractiveCounterWidget({super.key});

  @override
  State<InteractiveCounterWidget> createState() => _InteractiveCounterWidgetState();
}

class _InteractiveCounterWidgetState extends State<InteractiveCounterWidget> {
  int _count = 0;

  void _incrementCount() {
    setState(() {
      _count++;
    });
  }

  void _resetCount() {
    setState(() {
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              'Interactive Counter',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Text(
              '$_count',
              style: const TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const Text(
              'Taps',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _incrementCount,
                  icon: const Icon(Icons.add),
                  label: const Text('Increment'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: _resetCount,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// A StatefulWidget that allows users to toggle background colors.
class InteractiveColorChanger extends StatefulWidget {
  const InteractiveColorChanger({super.key});

  @override
  State<InteractiveColorChanger> createState() => _InteractiveColorChangerState();
}

class _InteractiveColorChangerState extends State<InteractiveColorChanger> {
  bool _isToggled = false;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = _isToggled ? Colors.deepPurple : Colors.orange;
    final String statusText = _isToggled ? 'Deep Purple Mode' : 'Orange Mode';

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            Icons.palette,
            size: 48,
            color: backgroundColor,
          ),
          const SizedBox(height: 16),
          Text(
            statusText,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: backgroundColor,
            ),
          ),
          const SizedBox(height: 24),
          SwitchListTile(
            title: const Text('Toggle State and Rebuild UI'),
            subtitle: const Text('This switch updates the internal state.'),
            value: _isToggled,
            activeColor: Colors.deepPurple,
            onChanged: (bool value) {
              setState(() {
                _isToggled = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
