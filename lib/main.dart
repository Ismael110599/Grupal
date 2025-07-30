import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'models/usuario.dart';
import 'screens/main_screen.dart';
import 'services/notification_service.dart';
import 'theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase
  await Firebase.initializeApp();

  // Inicializa Hive
  await Hive.initFlutter();
  Hive.registerAdapter(UsuarioAdapter());
  await Hive.openBox<Usuario>('usuarios');

  // Inicializa notificaciones locales y push
  await NotificationService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (_, theme, __) {
          return MaterialApp(
            title: 'App Usuarios',
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: theme.isDark ? ThemeMode.dark : ThemeMode.light,
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
