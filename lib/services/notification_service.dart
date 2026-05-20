import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  // Singleton pattern
  NotificationService._internal();
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _plugin.initialize(settings);

    // Request notification permission (Android 13+)
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> showLoginNotification(String name) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'login_channel',
      'Login Notifications',
      channelDescription: 'Notifikasi saat berhasil login',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails notifDetails = NotificationDetails(
      android: androidDetails,
    );

    await _plugin.show(
      0,
      'Login Berhasil! 🎉',
      'Selamat datang, $name!',
      notifDetails,
    );
  }
}
