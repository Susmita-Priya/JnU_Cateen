// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class rem extends StatelessWidget {
//   const rem({super.key});
//   Future<void> setReminder() async {
//     final prefs = await SharedPreferences.getInstance();
//     final lastNotificationDate = prefs.getString('lastNotificationDate');
//     print('abc');
//     if (lastNotificationDate == null) {
//       // Set the first notification to 7 days from now
//       final firstNotificationDate = DateTime.now();

//       await _scheduleNotification(firstNotificationDate);
//       await prefs.setString(
//           'lastNotificationDate', firstNotificationDate.toString());
//     } else {
//       final lastNotificationDateTime = DateTime.parse(lastNotificationDate);
//       final nextNotificationDateTime =
//           lastNotificationDateTime.add(const Duration(days: 7));

//       if (nextNotificationDateTime.isBefore(DateTime.now())) {
//         await _scheduleNotification(nextNotificationDateTime);
//         await prefs.setString(
//             'lastNotificationDate', nextNotificationDateTime.toString());
//       }
//     }
//   }

//   Future<void> _scheduleNotification(DateTime notificationDateTime) async {
//     final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     const androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'reminder_channel',
//       'Reminder Channel',
//       // 'Channel for Reminder Notifications',
//       importance: Importance.high,
//       priority: Priority.high,
//       playSound: true,
//     );
//     const platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);

//     await flutterLocalNotificationsPlugin.schedule(
//       0,
//       'Reminder',
//       'This is your reminder!',
//       notificationDateTime,
//       platformChannelSpecifics,
//     );
//   }

//   @override
//   void initState() {
//     setReminder();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
