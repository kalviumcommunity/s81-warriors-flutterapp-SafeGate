import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isLarge = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(title: const Text('Responsive Layout')),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: isLarge ? 200 : 120,
              color: Colors.lightBlueAccent,
              child: const Center(child: Text('Header Section')),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: isLarge
                  ? Row(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.amber,
                            child: const Center(child: Text('Left Panel')),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            color: Colors.greenAccent,
                            child: const Center(child: Text('Right Panel')),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            color: Colors.amber,
                            child: const Center(child: Text('Top Panel')),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            color: Colors.greenAccent,
                            child: const Center(child: Text('Bottom Panel')),
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 60,
              color: Colors.grey.shade300,
              child: const Center(child: Text('Footer Section')),
            ),
          ],
        ),
      ),
    );
  }
}
