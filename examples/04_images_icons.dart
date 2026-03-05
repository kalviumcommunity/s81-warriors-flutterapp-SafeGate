/// Example 04: Working with Images and Icons in Flutter
///
/// This example demonstrates how to use local assets (images) and
/// Flutter's built-in icons in your application.
///
/// SETUP REQUIRED:
/// 1. Create assets folder structure:
///    assets/
///    ├── images/
///    │   └── logo.png
///    └── icons/
///        └── custom_icon.png
///
/// 2. Register in pubspec.yaml:
///    flutter:
///      assets:
///        - assets/images/
///        - assets/icons/
///
/// 3. Run: flutter pub get

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const AssetsDemoApp());
}

class AssetsDemoApp extends StatelessWidget {
  const AssetsDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assets Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const AssetsDemoPage(),
    );
  }
}

class AssetsDemoPage extends StatelessWidget {
  const AssetsDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images & Icons Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section 1: Loading Local Images
            _buildSectionTitle('1. Local Image (Image.asset)'),
            const SizedBox(height: 8),
            _buildImageExample(),
            const SizedBox(height: 24),

            // Section 2: Image in Container Decoration
            _buildSectionTitle('2. Image in Container'),
            const SizedBox(height: 8),
            _buildContainerWithImage(),
            const SizedBox(height: 24),

            // Section 3: Material Icons
            _buildSectionTitle('3. Material Icons'),
            const SizedBox(height: 8),
            _buildMaterialIcons(),
            const SizedBox(height: 24),

            // Section 4: Cupertino Icons
            _buildSectionTitle('4. Cupertino Icons (iOS Style)'),
            const SizedBox(height: 8),
            _buildCupertinoIcons(),
            const SizedBox(height: 24),

            // Section 5: Combined Example
            _buildSectionTitle('5. Combined: Images + Icons'),
            const SizedBox(height: 8),
            _buildCombinedExample(),
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
      ),
    );
  }

  /// Example 1: Using Image.asset() to display local images
  Widget _buildImageExample() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Replace with your actual image path
            // Image.asset(
            //   'assets/images/logo.png',
            //   width: 150,
            //   height: 150,
            //   fit: BoxFit.cover,
            // ),
            
            // Placeholder when no image is available
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image, size: 48, color: Colors.grey),
                  SizedBox(height: 8),
                  Text('Image.asset()', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text('Code: Image.asset("assets/images/logo.png")'),
          ],
        ),
      ),
    );
  }

  /// Example 2: Using AssetImage in Container decoration
  Widget _buildContainerWithImage() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(12),
        // Uncomment when you have an actual image:
        // image: DecorationImage(
        //   image: AssetImage('assets/images/background.png'),
        //   fit: BoxFit.cover,
        // ),
      ),
      child: const Center(
        child: Text(
          'Container with DecorationImage',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// Example 3: Flutter's built-in Material Icons
  Widget _buildMaterialIcons() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [
            _buildIconWithLabel(Icons.home, 'Home', Colors.blue),
            _buildIconWithLabel(Icons.star, 'Star', Colors.amber),
            _buildIconWithLabel(Icons.favorite, 'Favorite', Colors.red),
            _buildIconWithLabel(Icons.settings, 'Settings', Colors.grey),
            _buildIconWithLabel(Icons.person, 'Person', Colors.purple),
            _buildIconWithLabel(Icons.security, 'Security', Colors.green),
          ],
        ),
      ),
    );
  }

  /// Example 4: Cupertino-style icons for iOS look
  Widget _buildCupertinoIcons() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [
            _buildIconWithLabel(CupertinoIcons.heart_fill, 'Heart', Colors.red),
            _buildIconWithLabel(CupertinoIcons.bell_fill, 'Bell', Colors.orange),
            _buildIconWithLabel(CupertinoIcons.gear_alt_fill, 'Gear', Colors.grey),
            _buildIconWithLabel(CupertinoIcons.shield_fill, 'Shield', Colors.blue),
          ],
        ),
      ),
    );
  }

  /// Example 5: Combining images and icons in a single UI
  Widget _buildCombinedExample() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Logo placeholder (replace with actual image)
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.flutter_dash, size: 48, color: Colors.blue),
            ),
            const SizedBox(height: 16),
            const Text(
              'My Flutter App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Powered by Flutter',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            // Platform icons row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.android, color: Colors.green[600], size: 32),
                const SizedBox(width: 12),
                Icon(Icons.apple, color: Colors.grey[700], size: 32),
                const SizedBox(width: 12),
                Icon(Icons.web, color: Colors.orange[600], size: 32),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconWithLabel(IconData icon, String label, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
