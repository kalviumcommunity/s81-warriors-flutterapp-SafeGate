import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:safegate_app/services/firebase_status.dart';
import '../services/auth_service.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = firebaseAvailable ? FirebaseAuth.instance.currentUser : null;
    final AuthService auth = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('SafeGate Dashboard'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sign Out',
            onPressed: () async {
              await auth.signOut();
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              }
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        color: const Color(0xFF121212), // Deep black background
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Profile Section
              Row(
                children: [
                  if (user?.photoURL != null)
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(user!.photoURL!),
                    )
                  else
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: const Icon(Icons.person, size: 30, color: Colors.black87),
                    ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome back,',
                          style: TextStyle(fontSize: 14, color: Colors.white54),
                        ),
                        Text(
                          user?.displayName ?? user?.email ?? 'Resident',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

               // Quick Actions Grid
              const Text(
                'Quick Actions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.5,
                children: [
                  _buildActionCard(
                    icon: Icons.person_add_alt_1,
                    title: 'Pre-Approve\nGuest',
                    color: Theme.of(context).colorScheme.primary,
                    onTap: () {
                       // Future Pre-approve feature
                    }
                  ),
                  _buildActionCard(
                    icon: Icons.local_shipping,
                    title: 'Expected\nDelivery',
                    color: Theme.of(context).colorScheme.primary,
                    onTap: () {
                      // Future delivery tracking
                    }
                  ),
                  _buildActionCard(
                    icon: Icons.notifications_active,
                    title: 'Emergency\nAlert',
                    color: Colors.redAccent,
                    onTap: () {
                      // Future emergency feature
                    }
                  ),
                  _buildActionCard(
                    icon: Icons.support_agent,
                    title: 'Contact\nSecurity',
                    color: Theme.of(context).colorScheme.primary,
                    onTap: () {
                      // Contact security
                    }
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Text(
                'Recent Visitors Logs',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 12),
              
              // Recent Visitors List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  final visitors = [
                    {'name': 'John Doe', 'type': 'Guest', 'time': 'Today, 10:30 AM', 'status': 'Checked Out', 'icon': Icons.person},
                    {'name': 'Amazon Delivery', 'type': 'Delivery', 'time': 'Today, 09:15 AM', 'status': 'Delivered', 'icon': Icons.inventory_2},
                    {'name': 'Jane Smith', 'type': 'Maid', 'time': 'Today, 08:00 AM', 'status': 'Inside', 'icon': Icons.cleaning_services},
                    {'name': 'Mike (Plumber)', 'type': 'Service', 'time': 'Yesterday, 02:30 PM', 'status': 'Checked Out', 'icon': Icons.plumbing},
                  ];
                  return Card(
                    color: const Color(0xFF1E1E1E),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Theme.of(context).colorScheme.primary.withAlpha(30)),
                    ),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(20),
                        child: Icon(visitors[index]['icon'] as IconData, color: Theme.of(context).colorScheme.primary),
                      ),
                      title: Text(visitors[index]['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      subtitle: Text('${visitors[index]['type']} • ${visitors[index]['time']}', style: const TextStyle(color: Colors.white54)),
                      trailing: Text(
                        visitors[index]['status'] as String,
                        style: TextStyle(
                          color: visitors[index]['status'] == 'Inside' ? Colors.greenAccent : Colors.white38,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard({required IconData icon, required String title, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withAlpha(50)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
