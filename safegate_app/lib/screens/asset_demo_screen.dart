import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AssetDemoScreen extends StatelessWidget {
  const AssetDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assets Demo')),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black54,
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', width: 150),
                const SizedBox(height: 20),
                const Text(
                  'Powered by Flutter',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Welcome to SafeGate Assets Demo',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Built-in Material Icons',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.flutter_dash, color: Colors.blue, size: 36),
                          SizedBox(width: 15),
                          Icon(Icons.android, color: Colors.green, size: 36),
                          SizedBox(width: 15),
                          Icon(Icons.apple, color: Colors.grey, size: 36),
                          SizedBox(width: 15),
                          Icon(Icons.star, color: Colors.amber, size: 36),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Cupertino Icons & Custom Asset Icon',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(CupertinoIcons.heart_fill, color: Colors.red, size: 36),
                          const SizedBox(width: 20),
                          Image.asset('assets/icons/profile.png', width: 36, height: 36, color: Colors.white),
                          const SizedBox(width: 20),
                          Image.asset('assets/icons/star.png', width: 36, height: 36),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 150,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/banner.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white24, width: 2),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      color: Colors.black54,
                      child: const Text(
                        'Banner Image Example',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
