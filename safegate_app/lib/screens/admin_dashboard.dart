import 'package:flutter/material.dart';
import '../widgets/safe_stat_card.dart';
import '../widgets/safe_management_card.dart';

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
                Expanded(child: SafeStatCard(title: 'Inside Now', count: '42', color: primaryColor)),
                const SizedBox(width: 12),
                const Expanded(child: SafeStatCard(title: 'Expected', count: '15', color: Colors.orangeAccent)),
                const SizedBox(width: 12),
                const Expanded(child: SafeStatCard(title: 'Rejected', count: '3', color: Colors.redAccent)),
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
                SafeManagementCard(
                  icon: Icons.people,
                  title: 'Resident\nDirectory',
                  color: primaryColor,
                  onTap: () {},
                ),
                SafeManagementCard(
                  icon: Icons.security,
                  title: 'Guard\nManagement',
                  color: Colors.blueAccent,
                  onTap: () {},
                ),
                SafeManagementCard(
                  icon: Icons.gavel,
                  title: 'Blacklist\nManager',
                  color: Colors.redAccent,
                  onTap: () {},
                ),
                SafeManagementCard(
                  icon: Icons.campaign,
                  title: 'Emergency\nBroadcast',
                  color: Colors.orangeAccent,
                  onTap: () {},
                ),
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
}
