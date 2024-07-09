import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static onTap(NotificationResponse response) {}

  static Future init() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  static void showBasicNotifications() async {
    NotificationDetails details =  NotificationDetails(
      android: AndroidNotificationDetails(
        "id 1",
        "basic notification",
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        sound: RawResourceAndroidNotificationSound("notification_sound.mp3".split(".").first),
      ),
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      "Basic Notification",
      "body",
      details,
      payload: 'Payload',
    );
  }

  static void showRepeatNotifications() async {
    NotificationDetails details = const NotificationDetails(
      android: AndroidNotificationDetails(
        "id 2",
        "Repeat notification",
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      ),
    );
    await flutterLocalNotificationsPlugin.periodicallyShow(
      1,
      "Repeat Notification",
      "body",
      RepeatInterval.everyMinute,
      details,
      payload: 'Payload',
    );
  }

  static void showScheduleNotifications() async {
    NotificationDetails details = const NotificationDetails(
      android: AndroidNotificationDetails(
        "id 3",
        "Scheduled notification",
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      ),
    );
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    await flutterLocalNotificationsPlugin.zonedSchedule(
      2,
      "Scheduled Notification",
      "body",
      tz.TZDateTime(tz.local, 2024, 07, 09, 12, 03),
      details,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static void cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
