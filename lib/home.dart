import 'package:cat/about.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'teacher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline), // About icon
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const AboutPage()), // Navigate to AboutPage
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Lottie Animation
          Lottie.asset(
            'assets/animation.json', // Replace with your actual animation file
            width: 500, // Adjust size as needed
            height: 500,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 1), // Spacing

          // Elevated Button
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TeacherScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                minimumSize: const Size(150, 60)),
            child: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}
