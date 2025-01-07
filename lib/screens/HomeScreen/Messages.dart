import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:quiz_app/controller/notification/notification_helper.dart';


DateTime scheduleTime = DateTime.now();

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  @override
  void initState() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationHelper.onActionReceivedMethod,
        onNotificationCreatedMethod:
        NotificationHelper.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
        NotificationHelper.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
        NotificationHelper.onDismissActionReceivedMethod);
    super.initState();
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 0, minute: 0),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
    print(_selectedTime);
  }

  Future<void> pushNotification() async {
    try {
      int uniqueId = DateTime.now().millisecondsSinceEpoch.remainder(100000);
      int hour = _selectedTime.hour;
      int minute = _selectedTime.minute;
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: uniqueId,
          channelKey: "basic_channel",
          title: "Quiz Notification",
          body: "This is a quiz notification scheduled at ${hour}h${minute}m ",
        ),
        schedule: NotificationCalendar(
          hour: hour,
          minute: minute,
          second: 0,
          millisecond: 0,
          timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
          repeats: true,
        ),
      );
      print("Notification scheduled successfully at ${hour.toString()}h${minute.toString()}");
      print(_selectedTime);
    } catch (e) {
      print("Error scheduling notification: $e");
      print(_selectedTime);
    }
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Notification',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 20),
              child: const Center(
                  child: Text(
                'Mark All as read',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              )))
        ],
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width,
                height: 74,
                child: const Row(children: [
                  CircleAvatar(backgroundColor: Colors.black, radius: 30
                      //  backgroundImage: Icon(Icons.language_outlined),
                      ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Basic level',
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 55,
                            ),
                            Text(
                              '35 min ago',
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            )
                          ]),
                      Text(
                        'Completed',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                ]),
              ),
              _buildDivider(),
              SizedBox(
                height: 10,
              ),
              // DatePickerTxt(),
              // SizedBox(
              //   height: 20,
              // ),
              // ScheduleBtn(),
              ElevatedButton(
                onPressed: _pickTime,
                child:  Text("Select Date Time"),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: pushNotification,
                child: Text("Schedule Notification"),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: (){
                  AwesomeNotifications().createNotification(
                    content: NotificationContent(
                      id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
                      channelKey: "basic_channel",
                      title: "Quiz App Notification!",
                      body: "Time to learn!!",
                    ),
                  );
                  print("${DateTime.now().hour}h${DateTime.now().minute+1}m");
                },
                child: Text("Instant Notification"),
              ),
            ],
          )),
    );
  }
  Container _buildDivider() {
    return Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey.shade400,
    );
  }
}

// class DatePickerTxt extends StatefulWidget {
//   const DatePickerTxt({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<DatePickerTxt> createState() => _DatePickerTxtState();
// }

// class _DatePickerTxtState extends State<DatePickerTxt> {
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         DatePicker.showDateTimePicker(
//           context,
//           showTitleActions: true,
//           onChanged: (date) => scheduleTime = date,
//           onConfirm: (date) {},
//         );
//       },
//       child: const Text(
//         'Select Date Time',
//         style: TextStyle(color: Colors.white),
//       ),
//     );
//   }
// }
//
// class ScheduleBtn extends StatelessWidget {
//   const ScheduleBtn({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       child: const Text('Schedule notifications'),
//       onPressed: () {
//         debugPrint('Notification Scheduled for $scheduleTime');
//         NotificationService().scheduleNotification(
//             title: 'Scheduled Notification',
//             body: '$scheduleTime',
//             scheduledNotificationDateTime: scheduleTime);
//       },
//     );
//   }
// }

