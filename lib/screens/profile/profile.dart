import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:freelance_app/config/user_state.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/AuthProvider.dart';
import '../../config/SharedPreferencesManager.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage();

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  String phoneNumber = "";
  String email = "";
  String name = '';
  String imageUrl = "";
  String joinedAt = " ";
  bool _isSameUser = false;
  String? token;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final loadedToken = await SharedPreferencesManager.getToken();
    setState(() {
      token = loadedToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Authprovider>(context);
    print("name is");
    print(provider.email);

    print(token);

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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ProfileBody(
              name: provider.name,
              email: provider.email!,
              phoneNumber: phoneNumber,
              joinedAt: joinedAt,
              isSameUser: _isSameUser,
              onWhatsAppTap: _openWhatsAppChat,
              onMailTap: _mailTo,
              onCallTap: _callPhoneNumber,
              onLogoutTap: _isSameUser ? _handleLogout : null,
            ),
    );
  }

  void _openWhatsAppChat() async {
    var url = 'https://wa.me/$phoneNumber?text=HelloWorld';
    launch(url);
  }

  void _mailTo() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
      query:
          'subject=Write subject here, please&body=Hello, please write details here',
    );
    final url = params.toString();
    launch(url);
  }

  void _callPhoneNumber() async {
    var url = 'tel://$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Error occurred';
    }
  }

  void _handleLogout() {
    _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => UserState(),
      ),
    );
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    Key? key,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.joinedAt,
    required this.isSameUser,
    required this.onWhatsAppTap,
    required this.onMailTap,
    required this.onCallTap,
    required this.onLogoutTap,
  }) : super(key: key);

  final String? name;
  final String email;
  final String phoneNumber;
  final String joinedAt;
  final bool isSameUser;
  final VoidCallback onWhatsAppTap;
  final VoidCallback onMailTap;
  final VoidCallback onCallTap;
  final VoidCallback? onLogoutTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileImage(name: name),
            const SizedBox(height: 16),
            Text(
              name ?? 'Name Here',
              style: const TextStyle(
                color: Color(0xff044404),
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(thickness: 1, color: Colors.white),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Information :',
                style: TextStyle(color: Colors.yellow, fontSize: 22.0),
              ),
            ),
            const SizedBox(height: 16),
            UserInfoRow(icon: Icons.email, content: email),
            UserInfoRow(icon: Icons.phone_android, content: phoneNumber),
            const SizedBox(height: 30),
            const Divider(thickness: 1, color: Colors.white),
            if (!isSameUser)
              ContactOptionsRow(
                onWhatsAppTap: onWhatsAppTap,
                onMailTap: onMailTap,
                onCallTap: onCallTap,
              ),
            const SizedBox(height: 25),
            const Divider(thickness: 1, color: Colors.white),
            const SizedBox(height: 25),
            if (isSameUser)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: MaterialButton(
                    onPressed: onLogoutTap,
                    color: Colors.orange[200],
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String? name;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: size.width * 0.26,
            height: size.width * 0.26,
            decoration: BoxDecoration(
              color: Color(0xff044404),
              shape: BoxShape.circle,
              border: Border.all(
                width: 8,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            child: ProfilePicture(
              name: name ?? "User",
              radius: 31,
              fontsize: 21,
              random: true,
            ))
      ],
    );
  }
}

class UserInfoRow extends StatelessWidget {
  const UserInfoRow({Key? key, required this.icon, required this.content})
      : super(key: key);

  final IconData icon;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.black,
        ),
        const SizedBox(width: 10),
        Text(
          content,
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}

class ContactOptionsRow extends StatelessWidget {
  const ContactOptionsRow({
    Key? key,
    required this.onWhatsAppTap,
    required this.onMailTap,
    required this.onCallTap,
  }) : super(key: key);

  final VoidCallback onWhatsAppTap;
  final VoidCallback onMailTap;
  final VoidCallback onCallTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ContactOption(
          color: Colors.green,
          onTap: onWhatsAppTap,
          icon: FontAwesome.whatsapp,
        ),
        ContactOption(
          color: Colors.red,
          onTap: onMailTap,
          icon: Icons.mail_outline,
        ),
        ContactOption(
          color: Colors.purple,
          onTap: onCallTap,
          icon: Icons.call_outlined,
        ),
      ],
    );
  }
}

class ContactOption extends StatelessWidget {
  const ContactOption({
    Key? key,
    required this.color,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  final Color color;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color,
      radius: 25,
      child: CircleAvatar(
        radius: 23,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: Icon(
            icon,
            color: color,
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}
