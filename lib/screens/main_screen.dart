// screens/main_screen.dart - Pantalla principal con navegación corregida
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'usuarios_screen.dart'; // ← NUEVA IMPORTACIÓN
import '../widgets/custom_drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Lista de pantallas para el BottomNavigationBar
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeScreen(),
      const ProfileScreen(),
      const SettingsScreen(),
      UsuariosScreen(), // ← NUEVA PANTALLA
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  String _getAppBarTitle() {
    switch (_currentIndex) {
      case 0:
        return 'Inicio';
      case 1:
        return 'Mi Perfil';
      case 2:
        return 'Configuración';
      case 3:
        return 'Usuarios'; // ← NUEVO TÍTULO
      default:
        return 'Mi App Flutter';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          _getAppBarTitle(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Inicio',
              tooltip: 'Pantalla principal',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Perfil',
              tooltip: 'Mi perfil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings),
              label: 'Configuración',
              tooltip: 'Configuraciones',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_outlined),
              activeIcon: Icon(Icons.group),
              label: 'Usuarios', // ← NUEVA PESTAÑA
              tooltip: 'Usuarios cargados desde JSON',
            ),
          ],
        ),
      ),
    );
  }
}
