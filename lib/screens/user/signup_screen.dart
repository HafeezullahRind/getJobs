import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/utils/clr.dart';
import 'package:freelance_app/utils/global_methods.dart';
import 'package:freelance_app/utils/layout.dart';
import 'package:freelance_app/utils/txt.dart';

import '../../config/Api_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  final _signUpFormKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();

  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();

  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();

  final TextEditingController _addressController = TextEditingController();
  final FocusNode _addressFocusNode = FocusNode();

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _phoneFocusNode.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
        body: Stack(
          children: [
            _signUpBackground(),
            Container(
              color: Colors.black54,
              child: Padding(
                padding: const EdgeInsets.all(layout.padding * 1.5),
                child: ListView(
                  children: [
                    Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: layout.padding),
                            child: _nameFormField(),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: layout.padding),
                            child: _emailFormField(),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: layout.padding),
                            child: _passwordFormField(),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: layout.padding),
                            child: _phoneFormField(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: layout.padding * 2),
                            child: _addressFormField(),
                          ),
                          _isLoading
                              ? _progressIndicator()
                              : Padding(
                                  padding: const EdgeInsets.all(layout.padding),
                                  child: _signUpButton(),
                                ),
                          _haveAccount(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _signUpBackground() {
    return Container(
      color: Colors.white,
    );
  }

  Widget _nameFormField() {
    return TextFormField(
      enabled: true,
      focusNode: _nameFocusNode,
      autofocus: false,
      controller: _nameController,
      style: txt.fieldLight,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _emailFocusNode.requestFocus(),
      decoration: InputDecoration(
        labelText: 'Name',
        labelStyle: txt.labelLight,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: txt.labelLight,
        errorStyle: txt.error,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.light,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.light,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.error,
          ),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a valid name';
        } else {
          return null;
        }
      },
    );
  }

  Widget _emailFormField() {
    return TextFormField(
      enabled: true,
      focusNode: _emailFocusNode,
      autofocus: false,
      controller: _emailController,
      style: txt.fieldLight,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _passwordFocusNode.requestFocus(),
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: txt.labelLight,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: txt.labelLight,
        errorStyle: txt.error,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.light,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.light,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.error,
          ),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty || !value.contains('@')) {
          return 'Please enter a valid name';
        } else {
          return null;
        }
      },
    );
  }

  Widget _passwordFormField() {
    return TextFormField(
      enabled: true,
      focusNode: _passwordFocusNode,
      autofocus: false,
      controller: _passwordController,
      style: txt.fieldLight,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _phoneFocusNode.requestFocus(),
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: txt.labelLight,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: txt.labelLight,
        errorStyle: txt.error,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.light,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.light,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.error,
          ),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty || value.length < 7) {
          return 'Please enter a valid password (min 7 characters)';
        } else {
          return null;
        }
      },
    );
  }

  Widget _phoneFormField() {
    return TextFormField(
      enabled: true,
      focusNode: _phoneFocusNode,
      autofocus: false,
      controller: _phoneController,
      style: txt.fieldLight,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _addressFocusNode.requestFocus(),
      decoration: InputDecoration(
        labelText: 'Phone number',
        labelStyle: txt.labelLight,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: txt.labelLight,
        errorStyle: txt.error,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.light,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.light,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.error,
          ),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a valid phone number';
        } else {
          return null;
        }
      },
    );
  }

  Widget _addressFormField() {
    return TextFormField(
      enabled: true,
      focusNode: _addressFocusNode,
      autofocus: false,
      controller: _addressController,
      style: txt.fieldLight,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      onEditingComplete: () => _addressFocusNode.unfocus(),
      decoration: InputDecoration(
        labelText: 'Address',
        labelStyle: txt.labelLight,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: txt.labelLight,
        errorStyle: txt.error,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.light,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.light,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.error,
          ),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a valid address';
        } else {
          return null;
        }
      },
    );
  }

  Widget _progressIndicator() {
    return const Center(
      child: SizedBox(
        height: 70,
        width: 70,
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _signUpButton() {
    return MaterialButton(
      onPressed: _submitSignUpForm,
      color: clr.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(layout.radius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(layout.padding * 0.75),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'Sign up   ',
                style: txt.button,
              ),
              Icon(
                Icons.person_add,
                color: Colors.white,
                size: layout.iconMedium,
              )
            ]),
      ),
    );
  }

  void _submitSignUpForm() async {
    final isValid = _signUpFormKey.currentState!.validate();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await ApiService.register(
          email: _emailController.text.trim().toLowerCase(),
          password: _passwordController.text.trim(),
          location: _addressController.text,
          name: _nameController.text,
        );

        if (response['success'] == true) {
          GlobalMethod.showErrorDialog(
            context: context,
            icon: Icons.check_sharp,
            iconColor: clr.error,
            title: 'Successfully',
            body: "Create successfully",
            buttonText: 'OK',
          );
        } else {
          GlobalMethod.showErrorDialog(
            context: context,
            icon: Icons.error,
            iconColor: clr.error,
            title: 'Registration Failed',
            body: response['message'],
            buttonText: 'OK',
          );
        }
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        GlobalMethod.showErrorDialog(
          context: context,
          icon: Icons.check_sharp,
          iconColor: clr.error,
          title: 'Successfully',
          body: '',
          buttonText: 'OK',
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  Widget _haveAccount() {
    return Center(
      child: RichText(
        text: TextSpan(children: [
          const TextSpan(
            text: 'Already have an account?',
            style: txt.body2Light,
          ),
          const TextSpan(text: '     '),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () =>
                  Navigator.canPop(context) ? Navigator.pop(context) : null,
            text: 'Login',
            style: txt.mediumTextButton,
          ),
        ]),
      ),
    );
  }
}
