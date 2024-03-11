import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/screens/profile/profile.dart';
import 'package:freelance_app/screens/user/login_screen.dart';
import 'package:freelance_app/utils/colors.dart';

import '../../config/SharedPreferencesManager.dart'; // Import the SharedPreferencesManager

class AboutUS extends StatelessWidget {
  const AboutUS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Column(
          children: const [
            SizedBox(
              height: 5,
            ),
            Text("About Us",
                style: TextStyle(color: Colors.orange, fontSize: 20)),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: Text(
                  '''Welcome to our Job finder app, the perfect platform for Job seekers and clients to connect and work together. Our app is designed to make the experience easy, efficient, and secure.

For Job Seekers, our app provides a wide range of job opportunities from various clients around the world. Our user-friendly interface allows you to showcase your skills, portfolio, and experience. You can bid on projects that match your expertise and receive payments for the work you complete.

For clients, our app offers a pool of talented and experienced Job seekers to choose from. You can post your projects, receive bids from freelancers, and hire the best match for your project. Our app provides a secure payment system, ensuring that you only pay for the work that meets your expectations.

Our Job finder app is the ideal platform for freelancers and clients to work together and build successful projects. Join our community today and let's create something great!'''),
            ),
          ],
        ),
      ),
    );
  }
}

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.orange,
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 100),
          child: Text(
            "Privacy Policy",
            style: TextStyle(color: Colors.orange),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                  '''Our Privacy Policy outlines the types of personal information that is received and collected by our app and how it is used.

- Information Collection and Use: We may collect personal information such as your name, email address, and contact information. This information is used to provide and improve our services.

- Log Data: Like many apps, we collect information that your device sends whenever you use our app. This may include information such as your device's IP address, browser type, and operating system.

- Cookies: We use cookies to store information about visitors' preferences, to record user-specific information on which pages the user accesses or visits, and to personalize or customize our app content based upon visitors' browser type or other information that the visitor sends via their device.

By using our app, you consent to our Privacy Policy and agree to its terms.'''),
            ),
          ],
        ),
      ),
    );
  }
}

class SideBar extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SideBar({Key? key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: SizedBox(
          width: 230,
          child: Drawer(
            child: ListView(
              padding: const EdgeInsets.only(top: 50, left: 10),
              children: [
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AboutUS()));
                  },
                  leading: const Icon(
                    Icons.post_add,
                    size: 30,
                    color: yellow,
                  ),
                  title: const Text(
                    "About Us",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  onTap: () async {
                    // Retrieve user ID from SharedPreferences
                    String? userId = await SharedPreferencesManager.getUserID();
                    if (userId != null) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfilePage()));
                    } else {
                      // Handle case where user ID is not available
                    }
                  },
                  leading: const Icon(
                    Icons.person,
                    size: 30,
                    color: yellow,
                  ),
                  title: const Text(
                    "Profile",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PrivacyPolicy()));
                  },
                  leading: const Icon(
                    Icons.privacy_tip,
                    size: 30,
                    color: yellow,
                  ),
                  title: const Text(
                    "Privacy Policy",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  onTap: () {
                    _auth.signOut();
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  leading: const Icon(
                    Icons.logout,
                    size: 30,
                    color: yellow,
                  ),
                  title: const Text(
                    "Log out",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
