import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/services/local_notification_service.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationService flutterLocalNotificationService;

  LocalNotificationProvider(this.flutterLocalNotificationService);

  bool _permission = false;
  bool get permission => _permission;

  bool _isReminderEnabled = false;
  bool get isReminderEnabled => _isReminderEnabled;

  List<PendingNotificationRequest> _pendingNotificationsRequests = [];
  List<PendingNotificationRequest> get pendingNotificationsRequests =>
      _pendingNotificationsRequests;

  Future<void> requestPermissions() async {
    _permission =
        await flutterLocalNotificationService.requestPermission() ?? false;
    notifyListeners();
  }

  Future<void> loadReminder() async {
    _isReminderEnabled =
        await flutterLocalNotificationService.getDailyReminderState();
    notifyListeners();
  }

  Future<void> setReminder(bool isEnabled) async {
    _isReminderEnabled = isEnabled;
    await flutterLocalNotificationService.setDailyReminder(isEnabled);
    notifyListeners();
  }
}
