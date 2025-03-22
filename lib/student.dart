import 'package:flutter/material.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;

class StudentScreen extends StatefulWidget {
  final String teacherName;
  final String subjectName;
  final String sectionName;
  final String sessionDate;
  final int studentCount;

  const StudentScreen({
    super.key,
    required this.teacherName,
    required this.subjectName,
    required this.sectionName,
    required this.sessionDate,
    required this.studentCount,
  });

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final TextEditingController _rollNumberController = TextEditingController();
  final List<String> _enteredRollNumbers = [];
  int _currentCount = 0;

  void _addRollNumber() {
    String rollNumber = _rollNumberController.text.trim();

    if (rollNumber.isEmpty) {
      _showMessage("Roll number cannot be empty!", Colors.red);
      return;
    }

    if (_enteredRollNumbers.contains(rollNumber)) {
      _showMessage("Duplicate roll number!", Colors.red);
      return;
    }

    setState(() {
      _enteredRollNumbers.add(rollNumber);
      _currentCount++;
      _rollNumberController.clear();
    });

    _showMessage("Roll number added!", Colors.lightBlue);

    if (_currentCount >= widget.studentCount) {
      _endSession();
    }
  }

  Future<void> _generatePDF(List<String> rollNumbers, String teacherName,
      String subject, String section, String date) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Attendance Report",
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Text("Teacher: $teacherName"),
            pw.Text("Subject: $subject"),
            pw.Text("Section: $section"),
            pw.Text("Date: $date"),
            pw.SizedBox(height: 15),
            pw.Text("Roll Numbers:",
                style:
                    pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            ...rollNumbers.map((roll) => pw.Text(roll)),
          ],
        ),
      ),
    );

    // Get the Downloads folder path
    final directory =
        Directory('/storage/emulated/0/Download'); // Path for Downloads folder
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    // Generate a unique filename with timestamp
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final file = File('${directory.path}/Attendance_Report_$timestamp.pdf');
    await file.writeAsBytes(await pdf.save());
  }

  void _endSession() {
    _generatePDF(
      _enteredRollNumbers,
      widget.teacherName,
      widget.subjectName,
      widget.sectionName,
      widget.sessionDate,
    );
    // Show confirmation dialog
    _showConfirmationDialog();
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Session Ended"),
          content:
              const Text("Attendance Report has been generated successfully!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Go back to the teacher screen
                Navigator.pop(context); // Go back to the home screen
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student")),
      body: Padding(
        padding: const EdgeInsets.only(
            left: 12.0, right: 12.0, bottom: 12.0), // Add bottom padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sessionDetailsCard(),
            const SizedBox(height: 20),
            _rollNumberInputField(),
            const SizedBox(height: 20),
            _enteredRollNumbersList(),
            const SizedBox(height: 10),
            _endSessionButton(),
          ],
        ),
      ),
    );
  }

  Widget _sessionDetailsCard() {
    return Stack(
      children: [
        // Session Details Card
        SizedBox(
          width: double.infinity,
          child: Card(
            elevation: 0, // No shadow
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            color: Colors.transparent, // Transparent background
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sessionDetailText("Teacher", widget.teacherName),
                  _sessionDetailText("Subject", widget.subjectName),
                  _sessionDetailText("Section", widget.sectionName),
                  _sessionDetailText("Date", widget.sessionDate),
                  _sessionDetailText(
                      "Students Required", widget.studentCount.toString()),
                ],
              ),
            ),
          ),
        ),

        // Separate rounded circle for count, positioned in front of the card
        Positioned(
          top: 120, // Positioning it above the card (adjust as needed)
          right: 10, // Position it towards the right side of the card
          child: Container(
            width: 50, // Size of the circle
            height: 50, // Size of the circle
            decoration: BoxDecoration(
              color: Colors.transparent, // Circle color
              shape: BoxShape.circle,
              border: Border.all(
                // Adds a border around the circle
                color: Colors.grey, // Border color
                width: 3, // Border thickness
              ), // Rounded shape
            ),
            child: Center(
              child: Text(
                '$_currentCount', // Dynamic count
                style: const TextStyle(
                  fontFamily: 'Courier',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30, // Font size inside the circle
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Custom Text Widget
  Widget _sessionDetailText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$label: ", // Bold label
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold, // Make label bold
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: value, // Normal value
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal, // Keep value normal
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rollNumberInputField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _rollNumberController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Enter Roll Number",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: _addRollNumber,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            minimumSize: const Size(90, 60),
          ),
          child: const Icon(Icons.send, size: 30),
        ),
      ],
    );
  }

  Widget _enteredRollNumbersList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        height: 150, // Adjust this height based on your UI needs
        child: ListView.builder(
          itemCount: _enteredRollNumbers.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: index.isEven
                    ? Colors.grey.withOpacity(0.4)
                    : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 24),
                  const SizedBox(width: 10),
                  Text(
                    "Roll No: ${_enteredRollNumbers[index]}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _endSessionButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _endSession,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          minimumSize: const Size(90, 60),
        ),
        child: const Icon(Icons.stop, size: 30),
      ),
    );
  }
}
