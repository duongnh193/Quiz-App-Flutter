import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_app/controller/authentication/firebase_auth_services.dart';
import 'package:quiz_app/controller/session/session_helper.dart';
import '../../widgets/format_dialog.dart';
import '../HomeScreen/Courses.dart';
import '../HomeScreen/HomeScreen.dart';
import '../HomeScreen/Messages.dart';
import '../HomeScreen/Profile.dart';
import '../HomeScreen/Search.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../login/login_screen.dart';

class HomePageScreen extends StatefulWidget {
  Timer? _sessionTimer;
  HomePageScreen({super.key});
  // final String title;

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> with WidgetsBindingObserver {
  Timer? _sessionTimer;
  int index = 0;
  List<bool> state_b = [true, false, false, false, false];
  List<Widget> widgets = [
    const HomeScreen(),
    const Courses(),
    const Search(),
    const Messages(),
    const Profile()
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startSessionTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_sessionTimer == null) {
      return;
    }
    if (state == AppLifecycleState.resumed || state == AppLifecycleState.paused) {
      _checkSession();
    }
  }

  Future<void> _checkSession() async {
    final isSessionValid = await SessionHelper.isSessionValid();
    if (!isSessionValid) {
      await SessionHelper.clearSession();
      _logout();
      return;
    }
  }

  void _startSessionTimer() {
    _sessionTimer?.cancel();
    if (_sessionTimer?.isActive == true) return;
    _sessionTimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      await _checkSession();
    });
  }

  void _logout() async {
    if(!mounted) return;
    _sessionTimer?.cancel();
    _sessionTimer = null;
    await showDialog(
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
          text: "End session",
          subtext:
          "The sesssion ended. Please login again to continue",
        );
      },
    );
    FirebaseAuthServices authServices = FirebaseAuthServices();
    await authServices.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
    );
  }

  Future<void> _onUserInteraction() async {
    print('User interacted at: ${DateTime.now()}');
    await SessionHelper.saveLoginTime();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Stack(
          children: [
            widgets.elementAt(index),
            Positioned(
                bottom: -10,
                left: 0,
                child: SizedBox(
                  width: size.width,
                  height: 80,
                  //color: Colors.white,
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: Size(size.width, 80),
                        painter: BNBCustomerPainter(),
                      ),
                      SizedBox(
                        width: size.width,
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            state_b[0]
                                ? IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.home,
                                    color: Colors.blue.shade700, size: 35))
                                : IconButton(
                                onPressed: () {
                                  setState(() {
                                    for (int i = 0;
                                    i < state_b.length;
                                    i++) {
                                      state_b[i] = false;
                                    }
                                    state_b[0] = true;
                                    index = 0;
                                  });
                                },
                                icon: const Icon(Icons.home,
                                    color: Colors.grey, size: 35)),
                            state_b[1]
                                ? IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.history,
                                    color: Colors.blue, size: 35))
                                : IconButton(
                                onPressed: () {
                                  setState(() {
                                    for (int i = 0;
                                    i < state_b.length;
                                    i++) {
                                      state_b[i] = false;
                                    }
                                    state_b[1] = true;
                                    index = 1;
                                  });
                                },
                                icon: const Icon(Icons.history,
                                    color: Colors.grey, size: 35)),
                            state_b[2]
                                ? IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.blue,
                                  size: 35,
                                ))
                                : IconButton(
                                onPressed: () {
                                  setState(() {
                                    for (int i = 0;
                                    i < state_b.length;
                                    i++) {
                                      state_b[i] = false;
                                    }
                                    state_b[2] = true;
                                    index = 2;
                                  });
                                },
                                icon: const Icon(Icons.search,
                                    color: Colors.grey, size: 35)),
                            state_b[3]
                                ? IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.message,
                                    color: Colors.blue, size: 35))
                                : IconButton(
                                onPressed: () {
                                  setState(() {
                                    for (int i = 0;
                                    i < state_b.length;
                                    i++) {
                                      state_b[i] = false;
                                    }
                                    state_b[3] = true;
                                    index = 3;
                                  });
                                },
                                icon: const Icon(Icons.message,
                                    color: Colors.grey, size: 35)),
                            state_b[4]
                                ? IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.person,
                                    color: Colors.blue, size: 35))
                                : IconButton(
                                onPressed: () {
                                  setState(() {
                                    for (int i = 0;
                                    i < state_b.length;
                                    i++) {
                                      state_b[i] = false;
                                    }
                                    state_b[4] = true;
                                    index = 4;
                                  });
                                },
                                icon: const Icon(Icons.person,
                                    color: Colors.grey, size: 35)),
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ));
  }
}

class BNBCustomerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.65, 0, size.width * 0.40, 20);
    // path.arcToPoint(Offset(size.width*0.60,20),radius: Radius.circular(10),clockwise: false);
    path.quadraticBezierTo(size.width * 0.1, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.8, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}