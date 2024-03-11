import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/screens/homescreen/home_screen.dart';

import '../../config/Api_service.dart';

class JobApplicationScreen extends StatefulWidget {
  final String jobTitle;
  const JobApplicationScreen({Key? key, required this.jobTitle})
      : super(key: key);

  @override
  _JobApplicationScreenState createState() => _JobApplicationScreenState();
}

class _JobApplicationScreenState extends State<JobApplicationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController coverLetterController = TextEditingController();

  File? resume;

  Future<void> _pickResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      setState(() {
        resume = File(result.files.single.path!);
      });
    }
  }

  bool isFormValid() {
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        resume != null;
  }

  void showExceptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Incomplete Form'),
          content: Text(
              'Please fill in all the required fields and upload your resume.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> applyForJob() async {
    if (isFormValid()) {
      try {
        final email = emailController.text;
        final name = nameController.text;
        final coverLetter = coverLetterController.text;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully Applied .'),
          ),
        );
        if (resume != null) {
          final response = await ApiService.ApplyJob(
            email: email,
            name: name,
            coverletter: coverLetter,
            resumeFile: resume!,
            context: context,
          );

          print(response);
          if (response['success'] == true) {
            print("Done");
          }
          // Handle the response from the API...
        } else {
          // Handle case where resume file is not selected...
        }
      } catch (e) {
        print(e);
        // Handle exceptions...
      }
    } else {
      showExceptionDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Handle back button press
          // Navigate to home screen instead of login screen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) =>
                  Homepage(), // Replace HomeScreen with your actual home screen widget
            ),
          );
          return true; // Prevent default behavior
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(
              color: Colors.orange,
            ),
            title: const Padding(
              padding: EdgeInsets.only(left: 180),
              child: Text(
                "getJOBS",
                style: TextStyle(color: Colors.orange),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      'Apply for ${widget.jobTitle}',
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Personal Information',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: TextStyle(
                        color: Colors.orangeAccent,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent),
                      ),
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Colors.orangeAccent,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent),
                      ),
                    ),
                  ),
                  TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Portfolio site',
                      labelStyle: TextStyle(
                        color: Colors.orangeAccent,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Cover Letter ',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.orangeAccent),
                      ),
                      Text(
                        'OPTIONAL',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: coverLetterController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Write a cover letter...',
                      labelStyle: TextStyle(
                        color: Colors.orangeAccent,
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Resume',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      _pickResume();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orangeAccent,
                      ),
                      child: Text(
                        'Upload Resume',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  resume != null
                      ? Text(
                          '${resume!.path.split('/').last}',
                          style: TextStyle(color: Colors.orangeAccent),
                        )
                      : Container(),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      applyForJob();

                      emailController.text = '';
                      nameController.text = '';
                      phoneController.text = '';

                      coverLetterController.text = '';
                      resume == '';
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orangeAccent,
                      ),
                      child: Text("Apply Now",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
