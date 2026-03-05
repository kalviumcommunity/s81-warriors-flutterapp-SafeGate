import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// A demonstration screen showcasing Flutter's asset handling capabilities.
/// 
/// This screen demonstrates:
/// - Loading local images using Image.asset()
/// - Using Flutter's built-in Material Icons
/// - Using Cupertino-style icons
/// - Combining images and icons in a cohesive UI
class AssetDemoScreen extends StatelessWidget {
  const AssetDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section 1: Local Image Display
            _buildSectionTitle('1. Local Image Display'),
            const SizedBox(height: 12),
            _buildImageCard(
              context,
              'Using Image.asset()',
              Image.asset(
                'assets/images/flutter_01.png',
                width: 200,
                height: 150,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return _buildPlaceholderImage('Image not found');
                },
              ),
            ),
            const SizedBox(height: 24),

            // Section 2: Image with Container Decoration
            _buildSectionTitle('2. Image in Container'),
            const SizedBox(height: 12),
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                image: const DecorationImage(
                  image: AssetImage('assets/images/flutter_02.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
                child: const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Welcome to Flutter!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Section 3: Built-in Material Icons
            _buildSectionTitle('3. Material Icons'),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildIconWithLabel(Icons.star, 'Star', Colors.amber),
                        _buildIconWithLabel(Icons.favorite, 'Favorite', Colors.red),
                        _buildIconWithLabel(Icons.home, 'Home', Colors.blue),
                        _buildIconWithLabel(Icons.settings, 'Settings', Colors.grey),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildIconWithLabel(Icons.security, 'Security', Colors.green),
                        _buildIconWithLabel(Icons.notifications, 'Alerts', Colors.orange),
                        _buildIconWithLabel(Icons.person, 'Profile', Colors.purple),
                        _buildIconWithLabel(Icons.exit_to_app, 'Logout', Colors.brown),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Section 4: Cupertino Icons (iOS Style)
            _buildSectionTitle('4. Cupertino Icons'),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCupertinoIcon(CupertinoIcons.heart_fill, 'Heart', Colors.red),
                    _buildCupertinoIcon(CupertinoIcons.bell_fill, 'Bell', Colors.orange),
                    _buildCupertinoIcon(CupertinoIcons.gear_alt_fill, 'Gear', Colors.grey),
                    _buildCupertinoIcon(CupertinoIcons.shield_fill, 'Shield', Colors.blue),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Section 5: Combined Image and Icons
            _buildSectionTitle('5. Combined Assets UI'),
            const SizedBox(height: 12),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/img.png',
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.image, size: 48, color: Colors.grey),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'SafeGate App',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Powered by Flutter',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Platform Icons Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.flutter_dash, color: Colors.blue[400], size: 36),
                        const SizedBox(width: 16),
                        Icon(Icons.android, color: Colors.green[600], size: 36),
                        const SizedBox(width: 16),
                        Icon(Icons.apple, color: Colors.grey[700], size: 36),
                        const SizedBox(width: 16),
                        Icon(Icons.web, color: Colors.orange[600], size: 36),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Section 6: SafeGate Feature Icons
            _buildSectionTitle('6. SafeGate Features'),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildFeatureRow(Icons.qr_code_scanner, 'QR Code Scanning', 'Fast visitor check-in'),
                    const Divider(),
                    _buildFeatureRow(Icons.verified_user, 'Identity Verification', 'Secure access control'),
                    const Divider(),
                    _buildFeatureRow(Icons.history, 'Visit History', 'Complete audit trail'),
                    const Divider(),
                    _buildFeatureRow(Icons.notifications_active, 'Real-time Alerts', 'Instant notifications'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  /// Builds a section title widget
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  /// Builds a card containing an image with a title
  Widget _buildImageCard(BuildContext context, String title, Widget imageWidget) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imageWidget,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a placeholder image widget for error cases
  Widget _buildPlaceholderImage(String message) {
    return Container(
      width: 200,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.image_not_supported, size: 48, color: Colors.grey),
          const SizedBox(height: 8),
          Text(message, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  /// Builds an icon with a label underneath
  Widget _buildIconWithLabel(IconData icon, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  /// Builds a Cupertino-style icon with label
  Widget _buildCupertinoIcon(IconData icon, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  /// Builds a feature row with icon, title, and description
  Widget _buildFeatureRow(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.blue, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
