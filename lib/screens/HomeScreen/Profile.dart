import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/constant.dart';
import 'package:quiz_app/screens/welcome/welcome_screen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool notifcation = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    String userName = _user?.displayName ?? "No Name";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: kSecondaryColor
          ) ,),
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 74,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.blue.shade800,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(4),
                    onTap: () {},
                    title: Text(
                        userName,
                      style: TextStyle(
                          fontSize: 19,
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w500),
                    ),
                    leading: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 35,
                      //  backgroundImage: Icon(Icons.language_outlined),
                    ),
                    trailing: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'General',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kPrimaryColor),
              ),
              Card(
                  elevation: 4,
                  margin: const EdgeInsets.fromLTRB(32, 8, 32, 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                bool isObscure = true;

                                return AlertDialog(
                                  content: SizedBox(
                                      height: 140,
                                      child: Column(
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors
                                                            .grey.shade200,
                                                        offset: const Offset(
                                                            5.0, 5.0),
                                                        blurRadius: 10.0,
                                                        spreadRadius: 2.0)
                                                  ],
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: TextField(
                                                obscureText: isObscure,
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    textBaseline:
                                                        TextBaseline.alphabetic,
                                                    height: 0.5,
                                                    fontFamily:
                                                        "Quicksand-Regular",
                                                    fontWeight:
                                                        FontWeight.bold),
                                                decoration: const InputDecoration(
                                                  hintText: 'Your New Password',
                                                  contentPadding:
                                                      EdgeInsets.all(10),
                                                  border: InputBorder.none,
                                                ),
                                              )),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  minimumSize: const Size(120, 40),
                                                  backgroundColor: Colors.red),
                                              onPressed: () {},
                                              child: const Text('Submit'))
                                        ],
                                      )),
                                );
                              });
                        },
                        title: const Text(
                          'Change Password',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                        leading: const Icon(
                          Icons.lock_outline,
                          color: Colors.black,
                        ),
                        trailing: const Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.black,
                        ),
                      ),
                      _buildDivider(),
                      ListTile(
                        onTap: () {},
                        title: const Text(
                          'Change Langage',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                        leading: const Icon(
                          Icons.language_outlined,
                          color: Colors.black,
                        ),
                        trailing: const Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.black,
                        ),
                      ),
                      _buildDivider(),
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Notification Settings',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              ),
              SwitchListTile(
                value: notifcation,
                onChanged: (val) {
                  setState(() {
                    notifcation = !notifcation;
                  });
                },
                activeColor: Colors.blue.shade800,
                contentPadding: const EdgeInsets.all(0),
                title: const Text('Received notification',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
              ),
              const SizedBox(
                height: 15,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.blue.shade800,
                child: ListTile(
                  onTap: () async {
                    await signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const WelcomeScreen();
                        },
                      ),
                    );
                  },
                  title: const Text(
                    'Sign Out',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  leading: const Icon(
                    Icons.doorbell_outlined, color: kSecondaryColor,
                    //  backgroundImage: Icon(Icons.language_outlined),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7), child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: double.infinity,
      height: 1,
      color: Colors.grey.shade400,
    );
  }

  Widget buildelementCard(BuildContext context, int index) {
    return Container(
        child: const Card(
            child: Row(
      children: [],
    )));
  }
}
