import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/constant.dart';
import '../../../widgets/date_picker_field.dart';
import '../../../widgets/format_dialog.dart';
import '../../login/component/account_check.dart';
import '../../login/component/or_divider.dart';
import '../../login/component/rounded_input_field.dart';
import '../../login/component/rounded_password_field.dart';
import '../../login/login_screen.dart';
import '../../../widgets/rounded_button.dart';
import 'package:quiz_app/controller/authentication/firebase_auth_services.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  bool _isLoading = false;
  String email = '';
  String pass = '';
  String name = '';

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  Future<void> updateDisplayName(String name) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Cập nhật thông tin người dùng
        await user.updateDisplayName(name);
        await user.reload();
        user = FirebaseAuth.instance.currentUser;
      } catch (e) {
        print("Error updating display name: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return SingleChildScrollView(
      child: SizedBox(
        height: size.height,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: size.height * 0.06, bottom: size.height * 0.04),
              child: Text(
                'CREATE YOUR ACCOUNT',
                style: Theme
                    .of(context)
                    .textTheme
                    .displaySmall,
              ),
            ),
            RoundedInputField(
              hintText: ' Full Name',
              controller: _fullNameController,
              onChanged: (value) {
                name = value;
              },
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            RoundedInputField(
              hintText: 'Email Address',
              controller: _emailController,
              onChanged: (value) {
                email = value;
              },
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            RoundedPasswordField(
              controller: _passwordController,
              textField: 'Password',
              onChanged: (value) {
                pass = value;
              },
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            RoundedPasswordField(
              controller: _passwordConfirmController,
              textField: 'Confirm Password',
              onChanged: (value) {},
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            _isLoading
                ? const CircularProgressIndicator(
              backgroundColor: kPrimaryColor,
            )
                : RoundedButton(
              press: () async {
                setState(() {
                  _isLoading = true;
                });
                if (_passwordController.text !=
                    _passwordConfirmController.text) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return FormatDialog(
                        text: 'Register Failed',
                        styleText: const TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        styleSubText: const TextStyle(fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                        subtext: 'Password does not match, Please check again',
                      );
                    },
                  );
                  setState(() {
                    _isLoading = false;
                  });
                  return;
                }
                try {
                  UserCredential userCredential = await FirebaseAuth
                      .instance
                      .createUserWithEmailAndPassword(
                    email: email,
                    password: pass,
                  );

                  User? user = userCredential.user;
                  if (user != null && !user.emailVerified) {
                    await user.sendEmailVerification();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Verification email sent! Check your inbox.')),
                    );
                  }

                  await updateDisplayName(name);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Registration successful!')),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                } on FirebaseAuthException catch (e) {
                  // print("Error Code: ${e.code}");
                  // print("Error Message: ${e.message}");
                  if (e.code == 'weak-password') {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return FormatDialog(
                          text: 'Register Failed',
                          styleText: const TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          subtext: 'Password weak, Please try again',
                          styleSubText: const TextStyle(fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        );
                      },
                    );
                    setState(() {
                      _isLoading = false;
                    });
                    return;
                  } else if (e.code == "email-already-in-use") {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return FormatDialog(
                            text: 'Resigter Failed',
                            styleText: const TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            styleSubText: const TextStyle(fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                            subtext:
                            'The email address is already in use by another account',
                          );
                        }
                    );
                    setState(() {
                      _isLoading = false;
                    });
                    return;
                  }
                }
                setState(() {
                  _isLoading = false;
                });
                _saveData(
                  email,
                  name,
                );
              },
              text: 'SIGN UP',
            ),
            AccountCheck(
              text: 'Already have an account?',
              textBtn: ' Log in',
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginScreen();
                    },
                  ),
                );
              },
            ),
            const OrDivider(),
            SizedBox(
              height: size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveData(
      String email,
      String name,
      ) async {
    final data = {
      'email': email,
      'name': name,
    };
  }
}