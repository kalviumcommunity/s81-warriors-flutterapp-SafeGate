import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Society Admin Panel'),
        backgroundColor: const Color(0xFF1A1A1A),
        foregroundColor: primaryColor,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
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
            // Analytics Overview
            const Text('Live Analytics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildStatCard('Inside Now', '42', primaryColor)),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard('Expected', '15', Colors.orangeAccent)),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard('Rejected', '3', Colors.redAccent)),
              ],
            ),
            const SizedBox(height: 24),

            // Management Grid
            const Text('Management Console', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _buildManagementCard(context, Icons.people, 'Resident\nDirectory', primaryColor),
                _buildManagementCard(context, Icons.security, 'Guard\nManagement', Colors.blueAccent),
                _buildManagementCard(context, Icons.gavel, 'Blacklist\nManager', Colors.redAccent),
                _buildManagementCard(context, Icons.campaign, 'Emergency\nBroadcast', Colors.orangeAccent),
              ],
            ),

            const SizedBox(height: 24),
            // Recent Security Logs
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Audit Logs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
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
                  {'event': 'New Guard Shift Started', 'time': '08:00 AM', 'by': 'System'},
                  {'event': 'Visitor Entry Denied (Blacklisted)', 'time': '09:45 AM', 'by': 'Gate 1'},
                  {'event': 'Maintenance Worker Entered', 'time': '10:30 AM', 'by': 'Gate 2'},
                ];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF1E1E1E),
                    child: Icon(Icons.history, color: primaryColor, size: 20),
                  ),
                  title: Text(logs[index]['event']!, style: const TextStyle(color: Colors.white, fontSize: 14)),
                  subtitle: Text('By ${logs[index]['by']} • ${logs[index]['time']}', style: const TextStyle(color: Colors.white54, fontSize: 12)),
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
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Text(count, style: TextStyle(color: color, fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(color: Colors.white70, fontSize: 12)),
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
