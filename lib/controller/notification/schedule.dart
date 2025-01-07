import 'package:awesome_notifications/awesome_notifications.dart';

void scheduleDailyNotification() async {
  // Kiểm tra quyền gửi thông báo
  bool isAllowedToSendNotification =
  await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotification) {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }
}