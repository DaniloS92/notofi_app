import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String token;
  static var _storage = new FlutterSecureStorage();

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future _backgroundHandler(RemoteMessage message) async {
    print('onBackgroundHandler: ${message.messageId}');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    print('onMessageHandler: ${message.messageId}');

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        .createNotificationChannel(channel);

    RemoteNotification notification = message.notification;
    String iconName = AndroidInitializationSettings('@mipmap/ic_launcher')
        .defaultIcon
        .toString();

    // Si `onMessage` es activado con una notificación, construimos nuestra propia
    // notificación local para mostrar a los usuarios, usando el canal creado.
    if (notification != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id, channel.name, channel.description,
                icon: iconName),
          ));
    }
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    print('onMessageOpenApp: ${message.messageId}');
  }

  static Future initializeApp() async {
    //Push Notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');
    await _storage.write(key: 'token_notification', value: token);

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    //Local Notifications
  }
}
