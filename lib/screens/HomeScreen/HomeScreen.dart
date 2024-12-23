// ignore: file_names
// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:quiz_app/screens/quiz/quiz_menu.dart';
import '../homepage/component/home_appbar.dart';
import 'AllCourses.dart';
import 'CoursePlaylist.dart';
import 'Filter.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/constant.dart';

import 'Messages.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Color _color = kSecondaryColor;
  final bool _color_s = false;

  final mail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Container(
            child: Container(
              height: size.height,
              padding: const EdgeInsets.all(20),
              color: kPrimaryBackgroundColor,
              child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: size.width * 0.8,
            height: size.height * 0.14,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 107, 140, 254),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start, // Đẩy nội dung lên trên
              children: [
                // Text nằm bên trái
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome to',
                        style: TextStyle(color: kSecondaryColor, fontSize: 15),
                      ),
                      const Text(
                        'Quiz App English ',
                        style: TextStyle(
                            color: kSecondaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                // Icon nằm ở góc trên phải
                Align(
                  alignment: Alignment.topRight,
                  child: const Icon(
                    Icons.notifications,
                    color: kSecondaryColor,
                    size: 34,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 40,
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/logo.jpeg",
              width: double.infinity,
              height: size.height*0.22,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const QuizMenu();
                      },
                    ),
                  );
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(25)),
                    width: size.width*0.6,
                    child: Material(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          // Image.asset(
                          //   'assets/images/onestar.jpg',
                          //   width: 100,
                          //   height: 100,
                          // ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.layers,
                                color: kSecondaryColor,
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Basic Level',
                                style: TextStyle(color: kSecondaryColor, fontSize: 20),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              // Text(
                              //   '4.9 (522 reviews)',
                              //   style: TextStyle(color: kSecondaryColor, fontSize: 15),
                              // )
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          )
                        ],
                      ),
                    )),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(25)),
                  width: size.width*0.6,
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        // Image.asset(
                        //   'assets/images/onestar.jpg',
                        //   width: 100,
                        //   height: 100,
                        // ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.layers,
                              color: kSecondaryColor,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Intermediate Level',
                              style: TextStyle(color: kSecondaryColor, fontSize: 20),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            // Text(
                            //   '4.9 (522 reviews)',
                            //   style: TextStyle(color: kSecondaryColor, fontSize: 15),
                            // )
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        )
                      ],
                    ),
                  )),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(25)),
                  width: size.width*0.6,
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        // Image.asset(
                        //   'assets/images/onestar.jpg',
                        //   width: 100,
                        //   height: 100,
                        // ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.layers,
                              color: kSecondaryColor,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Advanced Level',
                              style: TextStyle(color: kSecondaryColor, fontSize: 20),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        )
                      ],
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 65,
          ),
        ],
              ),
            )));
  }

  showLoaderDialog(BuildContext context) async {
    AlertDialog alertDialog = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.only(left: 8),
            child: const Text('Wait for It..'),
          )
        ],
      ),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  Future<void> launch() async {
    await Future.delayed(const Duration(milliseconds: 400));

    showLoaderDialog(context);
    print(context.toString());
    await Future.delayed(const Duration(seconds: 1));

    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (builder) => const CoursePlaylist()));
  }
}
