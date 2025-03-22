import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Developed by: Ehsan Tanvir',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'CAT',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'CAT is an offline mobile application designed for seamless attendance management for students and teachers. It enables teachers to create attendance sessions and allows students to enter their roll numbers directly on the teacher’s device.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Features:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildFeatureItem(
                'Offline Accessibility: Works without an internet connection.'),
            _buildFeatureItem(
                'Easy Attendance Tracking: Teachers can set up sessions with student count validation.'),
            _buildFeatureItem(
                'Real-Time Updates: Automatic live count increment and duplicate roll number prevention.'),
            _buildFeatureItem(
                'Automated PDF Reports: Attendance records are saved as PDFs in the device’s Downloads Directory.'),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                '© 2025 ehsan tanvir. All rights reserved.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(child: Text(feature, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
