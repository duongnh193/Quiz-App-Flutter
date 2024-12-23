// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/controller/authentication/get_data.dart';
// import '../../../controller/authentication/get_data.dart';
import '../../../models/users.dart';
import '../../forgot/forgot_screen.dart';
import '../../homepage/homepage.dart';
import '../../sign_up/sign_up_screen.dart';
import '../../../widgets/rounded_button.dart';
import 'account_check.dart';
import 'forgot_button.dart';
import '../../../widgets/format_dialog.dart';
import 'or_divider.dart';
import 'round_outline_button.dart';
import 'rounded_input_field.dart';
import 'rounded_password_field.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => LoginBodyState();
}

class LoginBodyState extends State<LoginBody> {
  static Users? user;
  // static Numerology? data;
  bool _isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String email = '';
  String pass = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                'LOG IN',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            RoundedInputField(
              controller: _emailController,
              hintText: 'Email Address',
              labelText: 'Email Address',
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
            ForgotButton(
              textBtn: 'Forgot Password?',
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ForgotScreen();
                    },
                  ),
                );
              },
            ),
            _isLoading
                ? const CircularProgressIndicator()
                : RoundedButton(
                    press: () async {
                      setState(() {
                        _isLoading = true;
                      });

                      final firestoreService = FirestoreService();

                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                          email: email,
                          password: pass,
                        );
                        user = await firestoreService.getData(email);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return HomePageScreen();
                            },
                          ),
                        );
                      } on FirebaseAuthException catch (e) {
                        print("Error Code: ${e.code}");
                        print("Error Message: ${e.message}");
                        if (e.code == "user-not-found") {
                          // Show error dialog
                          showDialog(
                            context: context,
                            builder: (context) {
                              return FormatDialog(
                                styleText: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                styleSubText: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                                text: "Login failed",
                                subtext:
                                    "User not found. Please check your email and try again.",
                              );
                            },
                          );
                          setState(() {
                            _isLoading = false;
                          });
                          return;
                        } else if (e.code == "invalid-credential") {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return FormatDialog(
                                styleText: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                styleSubText: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                                text: "Login failed",
                                subtext:
                                    "Wrong email or password. Please try again.",
                              );
                            },
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
                    },
                    text: 'LOG IN',
                  ),
            AccountCheck(
              text: 'Don\'t have an account?',
              textBtn: ' Sign up',
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignUpScreen();
                    },
                  ),
                );
              },
            ),
            const OrDivider(),
            SizedBox(
              height: size.height * 0.05,
            ),
            RoundedOutlineButton(
              textBtn: 'Sign in with Google',
              icon: 'assets/icons/google.png',
              margin: size.width * 0.14,
              press: () async {
                setState(() {
                  _isLoading = true;
                });
                try {
                  final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
                  if(googleSignInAccount != null){
                    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

                    // Tạo credential để đăng nhập với Firebase
                    final AuthCredential credential = GoogleAuthProvider.credential(
                      accessToken: googleSignInAuthentication.accessToken,
                      idToken: googleSignInAuthentication.idToken,
                    );

                    await FirebaseAuth.instance.signInWithCredential(credential);
                  };

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login successful!')),
                  );
                } on FirebaseAuthException catch (e) {
                  print('FirebaseAuthException: ${e.message}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${e.message}')),
                  );
                } catch (e) {
                  print('Error: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('An unexpected error occurred')),
                  );
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
            ),
            RoundedOutlineButton(
              textBtn: 'Sign in with Apple',
              press: () {},
              icon: 'assets/icons/apple-logo.png',
              margin: size.width * 0.15,
            ),
            RoundedOutlineButton(
              textBtn: 'Sign in with Facebook',
              press: () {},
              icon: 'assets/icons/facebook.png',
              margin: size.width * 0.11,
            ),
          ],
        ),
      ),
    );
  }
}
