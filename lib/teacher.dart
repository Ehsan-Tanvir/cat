import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'student.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({super.key});

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  final TextEditingController _teacherNameController = TextEditingController();
  final TextEditingController _subjectNameController = TextEditingController();
  final TextEditingController _sectionNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _studentCountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.text = _getCurrentDate(); // Set default session date
  }

  void _startSession() {
    if (_teacherNameController.text.isEmpty ||
        _subjectNameController.text.isEmpty ||
        _sectionNameController.text.isEmpty ||
        _studentCountController.text.isEmpty) {
      _showMessage("All fields are required!", Colors.red);
      return;
    }

    int? studentCount = int.tryParse(_studentCountController.text);
    if (studentCount == null || studentCount <= 0) {
      _showMessage("Enter a valid student count!", Colors.red);
      return;
    }

    // Navigate to StudentScreen with session details
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentScreen(
          teacherName: _teacherNameController.text,
          subjectName: _subjectNameController.text,
          sectionName: _sectionNameController.text,
          sessionDate: _dateController.text,
          studentCount: studentCount,
        ),
      ),
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
      appBar: AppBar(title: const Text('Teacher')),
      body: SingleChildScrollView(
        child: Center(
          // Center the form
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Add Lottie Animation
                Lottie.asset('assets/animation1.json',
                    height: 150,
                    width:
                        500), // Make sure you have an animation file at this path
                const SizedBox(height: 1), // Space between animation and form

                // Your form fields
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _teacherNameController,
                        decoration: _inputDecoration('Teacher Name'),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _subjectNameController,
                        decoration: _inputDecoration('Subject Name'),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _sectionNameController,
                        decoration: _inputDecoration('Section Name'),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _dateController,
                        decoration: InputDecoration(
                          labelText: 'Session Date',
                          filled: true,
                          prefixIcon: const Icon(Icons.calendar_today),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        readOnly: true,
                        onTap: _selectDate,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _studentCountController,
                        decoration: _inputDecoration('Students Count'),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _startSession,
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            minimumSize: const Size(150, 60)),
                        child: const Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
    );
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  String _getCurrentDate() {
    return "${DateTime.now().toLocal()}".split(' ')[0];
  }
}
