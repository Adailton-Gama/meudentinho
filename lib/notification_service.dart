// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:get/route_manager.dart';
// import 'package:meudentinho/pages/nossahistoria.dart';
// import 'package:meudentinho/services/routes.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest_all.dart' as tz;

// class CustomNotification {
//   final int id;
//   final String? title;
//   final String? body;
//   final String? payload;

//   CustomNotification({
//     required this.id,
//     required this.title,
//     required this.body,
//     required this.payload,
//   });
// }

// class NotificationService {
//   late FlutterLocalNotificationsPlugin localNotificationsPlugin;
//   late AndroidNotificationDetails androidDetails;
//   NotificationService() {
//     localNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     _setupNotifications();
//   }
//   _setupNotifications() async {
//     await _setupTimeZone();
//     await _initializeNotifications();
//   }

//   Future<void> _setupTimeZone() async {
//     tz.initializeTimeZones();
//     final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
//     tz.setLocalLocation(tz.getLocation(timeZoneName!));
//   }

//   _initializeNotifications() async {
//     const android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     //Fazer para o IOS
//     await localNotificationsPlugin.initialize(
//       const InitializationSettings(
//         android: android,
//       ),
//       onSelectNotification: _onSelectNotification,
//     );
//   }

//   _onSelectNotification(String? payload) {
//     if (payload != null && payload.isNotEmpty) {
//       Navigator.of(Routes.navigatorKey!.currentContext!)
//           .pushReplacementNamed(payload);
//     }
//   }

//   showNotification(CustomNotification notification) {
//     androidDetails = const AndroidNotificationDetails(
//       'Lembretes_notificatios_x',
//       'Lembretes',
//       channelDescription: 'Lembrete da escovação',
//       importance: Importance.max,
//       priority: Priority.max,
//       enableVibration: true,
//     );
//     localNotificationsPlugin.show(
//       notification.id,
//       notification.title,
//       notification.body,
//       NotificationDetails(
//         android: androidDetails,
//       ),
//       payload: notification.payload,
//     );
//   }

//   checkForNotification() async {
//     final details =
//         await localNotificationsPlugin.getNotificationAppLaunchDetails();
//     if (details != null && details.didNotificationLaunchApp) {
//       _onSelectNotification(details.payload);
//     }
//   }
// }
