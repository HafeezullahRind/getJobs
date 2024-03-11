import 'package:flutter/material.dart';
import 'package:freelance_app/screens/homescreen/home_screen.dart';
import 'package:freelance_app/screens/introduction_screen.dart';

import 'SharedPreferencesManager.dart';

class UserState extends StatelessWidget {
  const UserState({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: SharedPreferencesManager
          .getToken(), // Get the token from SharedPreferences
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text(
                'An error has occurred. Try again later.',
              ),
            ),
          );
        } else {
          final token = snapshot.data;
          // Check if the token exists
          if (token != null && token.isNotEmpty) {
            // User is authenticated, navigate to HomeScreen
            return const Homescreen();
          }
          if (token == null) {
            return const OnBoardingPage();
          } else {
            // User is not authenticated, navigate to OnBoardingPage
            return const OnBoardingPage();
          }
        }
      },
    );
  }
}
