import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../HomeScreen/Courses.dart';
import '../HomeScreen/HomeScreen.dart';
import '../HomeScreen/Messages.dart';
import '../HomeScreen/Profile.dart';
import '../HomeScreen/Search.dart';
import 'component/body.dart';
import 'package:page_transition/page_transition.dart';
import '../../constant.dart';
import '../../models/users.dart';
import '../login/component/body.dart';
import '../welcome/welcome_screen.dart';

// class HomePageScreen extends StatelessWidget {
//   // static Numerology? number;
//
//   Users? user = LoginBodyState.user;
//   HomePageScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     print(user?.name?? "duongdz");
//     return Scaffold(
//       backgroundColor: kPrimaryColor,
//       drawer: Drawer(
//         child: SafeArea(
//           child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 18),
//                   child: Card(
//                     child: ListTile(
//                       leading: Container(
//                         margin: const EdgeInsets.symmetric(vertical: 10),
//                         width: 30,
//                         height: 30,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(100),
//                           color: kPrimaryColor,
//                         ),
//                       ),
//                       title: Text(
//                         '${user?.name?? "Guest"}',
//                         style: const TextStyle(
//                           color: Colors.black,
//                           fontSize: 20,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       // subtitle: Text(
//                       //   '${user!.day}/${user!.month}/${user!.year}',
//                       //   style: const TextStyle(
//                       //     color: Colors.black,
//                       //     fontSize: 13,
//                       //     fontWeight: FontWeight.w400,
//                       //   ),
//                       // ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//                   child: ElevatedButton(
//                     child: const Text('Exit'),
//                     onPressed: () async {
//                       await FirebaseAuth.instance.signOut();
//                       Navigator.push(
//                         context,
//                         PageTransition(
//                           type: PageTransitionType.fade,
//                           child: const WelcomeScreen(),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ]),
//         ),
//       ),
//       body: Body(),
//     );
//   }
// }

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});
  // final String title;

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int index = 0;
  List<bool> state_b = [true, false, false, false, false];
  List<Widget> widgets = [
    const HomeScreen(),
    const Courses(results: [],),
    const Search(),
    const Messages(),
    const Profile()
  ];

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