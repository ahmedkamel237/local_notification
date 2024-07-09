import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationDetailsPage extends StatelessWidget {
  final NotificationResponse notificationResponse;
  const NotificationDetailsPage({super.key, required this.notificationResponse});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Details"),
        centerTitle:true,
      ),
      body: Column(
        children: [
          Text(notificationResponse.payload??''),
        ],
      ),
    );
  }
}
