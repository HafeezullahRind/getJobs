import 'package:flutter/material.dart';
import 'package:freelance_app/widgets/custom_button.dart';
import 'package:freelance_app/widgets/custom_textfield.dart';

import '../../config/Api_service.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> _sendResetCode() async {
    final String email = _emailController.text.trim();
    try {
      final response =
          await ApiService.forgetPassword(email: email, context: context);
      // Handle response as needed, e.g., show success message, navigate to another screen
      print(response); // You may want to handle the response differently
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reset code sent to $email')),
      );
    } catch (e) {
      print('Error sending reset code: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send reset code')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_sharp),
                    onPressed: () {
                      //Navigator.pop(context);
                    }),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Forgot Password?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("We will send you a link to reset your password.",
                  style: TextStyle(
                    color: Color(0xff8391A1),
                    fontSize: 20,
                    // fontWeight: FontWeight.bold,
                  )),
            ),
            CustomTextfield(
              myController: _emailController,
              hintText: "Enter your Email",
              isPassword: false,
            ),
            CustomButton(
              buttonText: "Send Code",
              buttonColor: Colors.black,
              textColor: Colors.white,
              onPressed: () {
                _sendResetCode();

                //Navigator.pop(context);
              },
            ),
            const Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(68, 8, 8, 8.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Remember Password?",
                      style: TextStyle(
                        color: Color(0xff1E232C),
                        fontSize: 15,
                      )),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text("  Login",
                        style: TextStyle(
                          color: Color(0xff35C2C1),
                          fontSize: 15,
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
