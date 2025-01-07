import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quiz_app/controller/notification/schedule.dart';
import 'package:quiz_app/screens/homepage/homepage.dart';
import 'package:quiz_app/theme/themes.dart';
import 'controller/notification/notification_helper.dart';
import 'controller/session/session_helper.dart';
import 'screens/welcome/welcome_screen.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: "basic_channel",
      channelName: "Basic Notification",
      channelDescription: "Basic notifications channel",
      defaultColor: Colors.teal,
      ledColor: Colors.white,
      importance: NotificationImportance.Max,
    )
  ]);
  scheduleDailyNotification();
  // final isSessionValid = await SessionHelper.isSessionValid() ?? false;
  // await NotificationService().initNotification();
  // tz.initializeTimeZones();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final bool isSessionValid;
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onUserInteraction,
      onScaleUpdate: (_) => _onUserInteraction(),
      child: MaterialApp(
        title: 'Quiz App',
        debugShowCheckedModeBanner: false,
        theme: TAppTheme.lightTheme,
        home: WelcomeScreen() ,
      ),
    );
  }
}
Future<void> _onUserInteraction() async {
  print('User interacted at: ${DateTime.now()}');
  await SessionHelper.saveLoginTime();
}
