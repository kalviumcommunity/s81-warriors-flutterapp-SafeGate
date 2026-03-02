import 'package:flutter/material.dart';

class SuperAdminDashboard extends StatelessWidget {
  const SuperAdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Super Admin Portal'),
        backgroundColor: const Color(0xFF1A1A1A),
        foregroundColor: primaryColor,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Global Overview
            const Text('Global Infrastructure', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildStatCard('Societies\nActive', '124', primaryColor)),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard('API Load', 'Normal', Colors.greenAccent)),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard('Pending\nOnboards', '7', Colors.orangeAccent)),
              ],
            ),
            const SizedBox(height: 24),

            // Management Grid
            const Text('Global Operations', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _buildManagementCard(context, Icons.business, 'Society\nOnboarding', primaryColor),
                _buildManagementCard(context, Icons.price_check, 'Subscription\nControl', Colors.greenAccent),
                _buildManagementCard(context, Icons.bar_chart, 'Usage\nMonitoring', Colors.blueAccent),
                _buildManagementCard(context, Icons.admin_panel_settings, 'Global Access\nLogs', Colors.redAccent),
              ],
            ),

            const SizedBox(height: 24),
            // Recent Security Logs
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Active Deployments', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                Text('View All', style: TextStyle(color: Colors.white54, fontSize: 14)),
              ],
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                final logs = [
                  {'event': 'Prestige Whitefield', 'status': 'Premium', 'date': 'v2.1.0 (Stable)'},
                  {'event': 'Emerald Heights', 'status': 'Basic', 'date': 'v2.1.0 (Stable)'},
                  {'event': 'Skyline Apartments', 'status': 'Suspended', 'date': 'Payment Pending'},
                ];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF1E1E1E),
                    child: Icon(Icons.location_city, color: primaryColor, size: 20),
                  ),
                  title: Text(logs[index]['event']!, style: const TextStyle(color: Colors.white, fontSize: 14)),
                  subtitle: Text('Status: ${logs[index]['status']} • ${logs[index]['date']}', style: const TextStyle(color: Colors.white54, fontSize: 12)),
                  trailing: Icon(Icons.arrow_forward_ios, size: 12, color: primaryColor),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Text(count, style: TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildManagementCard(BuildContext context, IconData icon, String title, Color color) {
    return InkWell(
      onTap: () {},
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
            const SizedBox(height: 12),
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
