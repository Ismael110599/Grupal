import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    // Configuración para Android
    const AndroidInitializationSettings androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    // Inicialización para iOS
    const DarwinInitializationSettings iosInit = DarwinInitializationSettings();

    // Inicialización general
    const InitializationSettings initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await _localNotificationsPlugin.initialize(initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        debugPrint('Notificación seleccionada: ${response.payload}');
      },
    );

    await _firebaseMessaging.requestPermission();

    // Obtener token del dispositivo
    String? token = await _firebaseMessaging.getToken();
    debugPrint("📱 Token FCM: $token");

    // Notificación en primer plano
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showLocalNotification(message);
    });

    // Notificación cuando se abre desde background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("🔄 App abierta desde notificación");
    });
  }

  void _showLocalNotification(RemoteMessage message) {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'canal_notificaciones',
      'Notificaciones Generales',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const NotificationDetails generalNotificationDetails = NotificationDetails(
      android: androidDetails,
    );

    _localNotificationsPlugin.show(
      DateTime.now().millisecond,
      message.notification?.title ?? 'Sin título',
      message.notification?.body ?? 'Sin contenido',
      generalNotificationDetails,
    );
  }
}
