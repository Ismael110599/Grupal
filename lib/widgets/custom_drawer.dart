// widgets/custom_drawer.dart - Drawer personalizado
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.flutter_dash,
                    size: 40,
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Mi App Flutter',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Versión 1.0.0',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Acerca de'),
            onTap: () {
              Navigator.pop(context);
              _showAboutDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Ayuda'),
            onTap: () {
              Navigator.pop(context);
              _showHelpDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback_outlined),
            title: const Text('Enviar comentarios'),
            onTap: () {
              Navigator.pop(context);
              _showFeedbackDialog(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('Política de privacidad'),
            onTap: () {
              Navigator.pop(context);
              _showPrivacyDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.article_outlined),
            title: const Text('Términos de uso'),
            onTap: () {
              Navigator.pop(context);
              _showTermsDialog(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Salir'),
            onTap: () {
              Navigator.pop(context);
              _showExitDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Mi App Flutter',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(
        Icons.flutter_dash,
        size: 48,
        color: Colors.deepPurple,
      ),
      children: [
        const Text(
          'Esta aplicación demuestra la implementación de navegación avanzada en Flutter, '
          'incluyendo BottomNavigationBar y Drawer personalizado.',
        ),
      ],
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Ayuda'),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• Usa la barra inferior para navegar entre secciones'),
                Text('• Desliza desde el borde izquierdo para abrir el menú'),
                Text('• Toca los botones para interactuar con la aplicación'),
                Text('• Usa los gestos de deslizar para cambiar pantallas'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Entendido'),
              ),
            ],
          ),
    );
  }

  void _showFeedbackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Enviar comentarios'),
            content: const Text(
              'Tus comentarios son importantes para nosotros. '
              'Puedes enviarnos tus sugerencias a través del repositorio de GitHub.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cerrar'),
              ),
            ],
          ),
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Política de privacidad'),
            content: const Text(
              'Esta aplicación no recopila datos personales. '
              'Toda la información se almacena localmente en tu dispositivo.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Aceptar'),
              ),
            ],
          ),
    );
  }

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Términos de uso'),
            content: const Text(
              'Esta aplicación es un proyecto educativo. '
              'El uso de este software es bajo tu propia responsabilidad.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Aceptar'),
              ),
            ],
          ),
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Salir de la aplicación'),
            content: const Text('¿Estás seguro de que quieres salir?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // En una app real, aquí cerrarías la aplicación
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Aplicación cerrada simulada'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text('Salir'),
              ),
            ],
          ),
    );
  }
}
