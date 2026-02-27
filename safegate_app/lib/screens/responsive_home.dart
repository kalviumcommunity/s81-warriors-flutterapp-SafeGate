import 'package:flutter/material.dart';

/// A responsive home screen that adapts to different device sizes and orientations
/// Demonstrates the use of MediaQuery, LayoutBuilder, and flexible widgets
class ResponsiveHome extends StatefulWidget {
  const ResponsiveHome({Key? key}) : super(key: key);

  @override
  State<ResponsiveHome> createState() => _ResponsiveHomeState();
}

class _ResponsiveHomeState extends State<ResponsiveHome> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isTablet = screenWidth > 600;
    bool isLandscape = screenWidth > screenHeight;

    return Scaffold(
      // Responsive AppBar
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.deepPurple,
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Responsive SafeGate',
            style: TextStyle(
              fontSize: isTablet ? 24 : 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
            iconSize: isTablet ? 28 : 24,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
            iconSize: isTablet ? 28 : 24,
          ),
        ],
      ),

      // Main content area
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome header section
                    _buildWelcomeHeader(isTablet),
                    SizedBox(height: isTablet ? 32 : 24),

                    // Stats cards section - responsive grid
                    _buildStatsSection(isTablet, isLandscape),
                    SizedBox(height: isTablet ? 32 : 24),

                    // Main content area - changes layout based on device
                    if (isTablet && isLandscape)
                      _buildTabletLandscapeLayout()
                    else if (isTablet)
                      _buildTabletPortraitLayout()
                    else
                      _buildPhoneLayout(),

                    SizedBox(height: isTablet ? 32 : 24),

                    // Action buttons section
                    _buildActionButtons(isTablet, isLandscape),
                  ],
                ),
              ),
            );
          },
        ),
      ),

      // Footer section with bottom navigation
      bottomNavigationBar: _buildBottomNavigation(isTablet),

      // Floating action button - responsive size
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.deepPurple,
        child: Icon(
          Icons.add,
          size: isTablet ? 32 : 24,
        ),
      ),
    );
  }

  /// Welcome header with responsive text sizes
  Widget _buildWelcomeHeader(bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome Back!',
          style: TextStyle(
            fontSize: isTablet ? 32 : 24,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Your dashboard adapts to every screen size',
          style: TextStyle(
            fontSize: isTablet ? 18 : 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  /// Stats cards that adapt to screen size
  Widget _buildStatsSection(bool isTablet, bool isLandscape) {
    // Determine grid columns based on device type and orientation
    int crossAxisCount = isTablet && isLandscape ? 4 : (isTablet ? 3 : 2);

    List<Map<String, dynamic>> stats = [
      {'icon': Icons.security, 'label': 'Security', 'value': '98%', 'color': Colors.green},
      {'icon': Icons.people, 'label': 'Users', 'value': '1.2K', 'color': Colors.blue},
      {'icon': Icons.access_time, 'label': 'Uptime', 'value': '99.9%', 'color': Colors.orange},
      {'icon': Icons.warning, 'label': 'Alerts', 'value': '3', 'color': Colors.red},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: isTablet ? 16 : 12,
        mainAxisSpacing: isTablet ? 16 : 12,
        childAspectRatio: isTablet ? 1.2 : 1.0,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        return _buildStatCard(
          stats[index]['icon'],
          stats[index]['label'],
          stats[index]['value'],
          stats[index]['color'],
          isTablet,
        );
      },
    );
  }

  /// Individual stat card widget
  Widget _buildStatCard(
    IconData icon,
    String label,
    String value,
    Color color,
    bool isTablet,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(51),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 20 : 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: isTablet ? 40 : 32,
              color: color,
            ),
            SizedBox(height: isTablet ? 12 : 8),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: isTablet ? 24 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: isTablet ? 14 : 12,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Phone layout - single column
  Widget _buildPhoneLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Recent Activity', false),
        const SizedBox(height: 12),
        ..._buildActivityItems(false),
      ],
    );
  }

  /// Tablet portrait layout - enhanced single column
  Widget _buildTabletPortraitLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Recent Activity', true),
        const SizedBox(height: 16),
        ..._buildActivityItems(true),
      ],
    );
  }

  /// Tablet landscape layout - two columns
  Widget _buildTabletLandscapeLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Recent Activity', true),
              const SizedBox(height: 16),
              ..._buildActivityItems(true, itemCount: 3),
            ],
          ),
        ),
        const SizedBox(width: 24),
        // Right column
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Quick Actions', true),
              const SizedBox(height: 16),
              _buildQuickActionsGrid(true),
            ],
          ),
        ),
      ],
    );
  }

  /// Section title widget
  Widget _buildSectionTitle(String title, bool isTablet) {
    return Text(
      title,
      style: TextStyle(
        fontSize: isTablet ? 24 : 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  /// Activity items list
  List<Widget> _buildActivityItems(bool isTablet, {int itemCount = 5}) {
    List<Map<String, String>> activities = [
      {'title': 'Security check completed', 'time': '2 min ago'},
      {'title': 'New user registered', 'time': '15 min ago'},
      {'title': 'System update available', 'time': '1 hour ago'},
      {'title': 'Backup completed', 'time': '3 hours ago'},
      {'title': 'Alert resolved', 'time': '5 hours ago'},
    ];

    return activities.take(itemCount).map((activity) {
      return Container(
        margin: EdgeInsets.only(bottom: isTablet ? 12 : 8),
        padding: EdgeInsets.all(isTablet ? 16 : 12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              Icons.circle,
              size: isTablet ? 12 : 8,
              color: Colors.deepPurple,
            ),
            SizedBox(width: isTablet ? 12 : 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity['title']!,
                    style: TextStyle(
                      fontSize: isTablet ? 16 : 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    activity['time']!,
                    style: TextStyle(
                      fontSize: isTablet ? 14 : 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  /// Quick actions grid for tablet landscape
  Widget _buildQuickActionsGrid(bool isTablet) {
    List<Map<String, dynamic>> actions = [
      {'icon': Icons.add_circle, 'label': 'Add User', 'color': Colors.blue},
      {'icon': Icons.report, 'label': 'Reports', 'color': Colors.orange},
      {'icon': Icons.analytics, 'label': 'Analytics', 'color': Colors.green},
      {'icon': Icons.backup, 'label': 'Backup', 'color': Colors.purple},
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: actions.map((action) {
        return Container(
          width: isTablet ? 140 : 120,
          height: isTablet ? 140 : 120,
          decoration: BoxDecoration(
            color: (action['color'] as Color).withAlpha(26),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: action['color'], width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                action['icon'],
                size: isTablet ? 48 : 40,
                color: action['color'],
              ),
              const SizedBox(height: 8),
              Text(
                action['label'],
                style: TextStyle(
                  fontSize: isTablet ? 14 : 12,
                  fontWeight: FontWeight.w600,
                  color: action['color'],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// Action buttons that adapt to screen size
  Widget _buildActionButtons(bool isTablet, bool isLandscape) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use Row for tablets in landscape, Column for everything else
        if (isTablet && isLandscape) {
          return Row(
            children: [
              Expanded(child: _buildPrimaryButton('View Dashboard', isTablet)),
              const SizedBox(width: 16),
              Expanded(child: _buildSecondaryButton('Settings', isTablet)),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildPrimaryButton('View Dashboard', isTablet),
              SizedBox(height: isTablet ? 16 : 12),
              _buildSecondaryButton('Settings', isTablet),
            ],
          );
        }
      },
    );
  }

  /// Primary button widget
  Widget _buildPrimaryButton(String label, bool isTablet) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        padding: EdgeInsets.symmetric(
          vertical: isTablet ? 20 : 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: isTablet ? 18 : 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Secondary button widget
  Widget _buildSecondaryButton(String label, bool isTablet) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: isTablet ? 20 : 16,
        ),
        side: const BorderSide(color: Colors.deepPurple, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: isTablet ? 18 : 16,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  /// Bottom navigation bar with responsive sizing
  Widget _buildBottomNavigation(bool isTablet) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
      iconSize: isTablet ? 28 : 24,
      selectedFontSize: isTablet ? 14 : 12,
      unselectedFontSize: isTablet ? 12 : 10,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
