import 'package:flutter/material.dart';

/// ScrollableViews - A demo showcasing ListView and GridView widgets
/// 
/// This screen demonstrates:
/// - ListView.builder for horizontal scrolling lists
/// - GridView.builder for grid layouts
/// - Combining multiple scrollable views in a single screen
class ScrollableViews extends StatelessWidget {
  const ScrollableViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scrollable Views'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ListView Section Header
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'ListView Example (Horizontal)',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Swipe horizontally to scroll through the cards',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 8),
            
            // Horizontal ListView
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    width: 150,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.teal[100 * ((index % 5) + 2)],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.credit_card,
                            size: 40,
                            color: Colors.teal[900],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Card ${index + 1}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.teal[900],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            const Divider(thickness: 2, height: 32),
            
            // Vertical ListView Section
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'ListView Example (Vertical)',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            // Vertical ListView with ListTiles
            SizedBox(
              height: 250,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  final statuses = ['Online', 'Offline', 'Away', 'Busy', 'Online'];
                  final colors = [Colors.green, Colors.grey, Colors.orange, Colors.red, Colors.green];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.teal[300],
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text('User ${index + 1}'),
                    subtitle: Row(
                      children: [
                        Icon(Icons.circle, size: 10, color: colors[index]),
                        const SizedBox(width: 4),
                        Text(statuses[index]),
                      ],
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Tapped on User ${index + 1}')),
                      );
                    },
                  );
                },
              ),
            ),
            
            const Divider(thickness: 2, height: 32),
            
            // GridView Section Header
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'GridView Example',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'A responsive grid layout with colorful tiles',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 8),
            
            // GridView
            Container(
              height: 400,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  final icons = [
                    Icons.home,
                    Icons.person,
                    Icons.settings,
                    Icons.notifications,
                    Icons.security,
                    Icons.info,
                  ];
                  final labels = [
                    'Home',
                    'Profile',
                    'Settings',
                    'Alerts',
                    'Security',
                    'About',
                  ];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.primaries[index % Colors.primaries.length],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Tapped on ${labels[index]}')),
                        );
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              icons[index],
                              size: 40,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              labels[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 20),
            
            // GridView.count Example
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'GridView.count Example',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildSimpleTile(Colors.red, 'Red'),
                  _buildSimpleTile(Colors.green, 'Green'),
                  _buildSimpleTile(Colors.blue, 'Blue'),
                  _buildSimpleTile(Colors.yellow, 'Yellow'),
                  _buildSimpleTile(Colors.purple, 'Purple'),
                  _buildSimpleTile(Colors.orange, 'Orange'),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSimpleTile(Color color, String label) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
