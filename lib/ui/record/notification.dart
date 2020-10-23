//packages
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//my files
import 'package:zikanri/config.dart';
//notification action
void notification(String s, int length) async {
  AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'Channel ID',
    'Channel title',
    'channel body',
    priority: Priority.Max,
    importance: Importance.Max,
    ticker: 'test',
  );
  IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

  NotificationDetails notificationDetails =
      NotificationDetails(androidNotificationDetails, iosNotificationDetails);
  await flutterNotification.show(
    0,
    '活動',
    (length + 1).toString() + '件目: ' + s,
    notificationDetails,
  );
}
