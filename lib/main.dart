import 'package:flutter/material.dart';
import 'package:local_notification/local_servies.dart';
import 'package:local_notification/notification_details_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Local Notification"),
        ),
        body:const NotificationBody(),
      ),
    );
  }
}
class NotificationBody extends StatefulWidget {
  const NotificationBody({super.key});

  @override
  State<NotificationBody> createState() => _NotificationBodyState();
}

class _NotificationBodyState extends State<NotificationBody> {
  @override
  void initState() {
    listenToNotificationStream();
    super.initState();
  }
  void listenToNotificationStream() {
    LocalNotificationService.streamController.stream.listen(
          (notificationResponse) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => NotificationDetailsPage(
              notificationResponse: notificationResponse,
            ),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListTile(
          trailing: InkWell(
            onTap: () {
              LocalNotificationService.cancelNotification(0);
            },
            child: const Icon(
              Icons.cancel,
              color: Colors.red,
            ),
          ),
          title: const Text("Basic Notification"),
          onTap: () {
            LocalNotificationService.showBasicNotifications();
          },
          leading: const Icon(Icons.alarm),
        ),
        ListTile(
          trailing: InkWell(
            onTap: () {
              LocalNotificationService.cancelNotification(1);
            },
            child: const Icon(
              Icons.cancel,
              color: Colors.red,
            ),
          ),
          title: const Text("Repeat Notification"),
          onTap: () {
            LocalNotificationService.showRepeatNotifications();
          },
          leading: const Icon(Icons.alarm),
        ),
        ListTile(
          trailing: InkWell(
            onTap: () {
              LocalNotificationService.cancelNotification(2);
            },
            child: const Icon(
              Icons.cancel,
              color: Colors.red,
            ),
          ),
          title: const Text("Scheduled Notification"),
          onTap: () {
            LocalNotificationService.showScheduleNotifications();
          },
          leading: const Icon(Icons.alarm),
        ),
        const SizedBox(
          height: 24,
        ),
        MaterialButton(
          color: Colors.red,
          child: const Text(
            "Cancel All Notification",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          onPressed: () {
            LocalNotificationService.cancelAllNotifications();
          },
        )
      ],
    );
  }
}
