import 'package:flutter/material.dart';
import 'package:freelance_app/screens/homescreen/home_screen.dart';
import 'package:freelance_app/screens/user/forgot_password.dart';
import 'package:freelance_app/screens/user/signup_screen.dart';
import 'package:freelance_app/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../../config/Api_service.dart';
import '../../config/AuthProvider.dart';
import '../../config/SharedPreferencesManager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<Authprovider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.orange,
        ),
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 230),
          child: Text(
            "getJOBS",
            style: TextStyle(color: Colors.orange),
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: SingleChildScrollView(
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
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Welcome Back! Glad \nto see you again",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CustomTextfield(
                myController: _emailController,
                hintText: "Enter your Email",
                isPassword: false,
              ),
              CustomTextfield(
                myController: _passwordController,
                hintText: "Enter your Password",
                isPassword: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPassword(),
                        ),
                      );
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Color(0xff6A707C),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              CustomButton(
                buttonText: "Login",
                buttonColor: Colors.black,
                textColor: Colors.white,
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                  try {
                    setState(() {
                      _isLoading = true;
                    });

                    // Call your API service for user login
                    final response = await ApiService.login(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                    );

                    // Check if the login was successful
                    if (response['success'] == true) {
                      final userID = response['data']['id'].toString();
                      userProvider
                          .setUserID(userID); // Set the userID in AuthProvider
                      await SharedPreferencesManager.setToken(
                          response['data']['token']);
                      await SharedPreferencesManager.setUserID(
                          response['data']['id'].toString());
                      userProvider.setUserdetails(
                          email: response['data']['email'],
                          name: response['data']['name'],
                          image: response['data']['image']);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Homescreen(),
                        ),
                      );
                    } else {
                      // Show error message
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text(
                            "Login Failed",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          content: Text(response['message']),
                          actions: [
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.amber)),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(
                                    context); // Close the ProgressDialog
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                    }
                  } catch (e) {
                    debugPrint("error is $e");
                    Navigator.pop(context);

                    // Show error message
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Login Failed",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent)),
                        content: Text(
                            "An error occurred during login. Please try again Or Check Email or Password."),
                        actions: [
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.amber)),
                            onPressed: () {
                              Navigator.pop(context); // Close the error dialog
                            },
                            child: Text("OK"),
                          ),
                        ],
                      ),
                    );
                  } finally {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(48, 8, 8, 8.0),
                child: Row(
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Color(0xff1E232C),
                        fontSize: 15,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "  Register Now",
                        style: TextStyle(
                          color: Color(0xff35C2C1),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextfield extends StatefulWidget {
  final TextEditingController myController;
  final String hintText;
  final bool isPassword;

  const CustomTextfield({
    Key? key,
    required this.myController,
    required this.hintText,
    this.isPassword = false,
  }) : super(key: key);

  @override
  _CustomTextfieldState createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: widget.myController,
        obscureText: widget.isPassword ? _obscureText : false,
        decoration: InputDecoration(
          hintText: widget.hintText,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.orange,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
