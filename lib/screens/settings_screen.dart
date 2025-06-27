// screens/settings_screen.dart - Nueva pantalla de configuración
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _soundEnabled = true;
  double _fontSize = 16.0;
  String _selectedLanguage = 'Español';

  final List<String> _languages = ['Español', 'English', 'Français', 'Deutsch'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sección de Notificaciones
            _buildSectionCard('Notificaciones', Icons.notifications, [
              SwitchListTile(
                title: const Text('Habilitar notificaciones'),
                subtitle: const Text('Recibir alertas y actualizaciones'),
                value: _notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Sonidos'),
                subtitle: const Text('Reproducir sonidos de notificación'),
                value: _soundEnabled,
                onChanged: (value) {
                  setState(() {
                    _soundEnabled = value;
                  });
                },
              ),
            ]),

            const SizedBox(height: 20),

            // Sección de Apariencia
            _buildSectionCard('Apariencia', Icons.palette, [
              SwitchListTile(
                title: const Text('Modo oscuro'),
                subtitle: const Text('Usar tema oscuro'),
                value: _darkModeEnabled,
                onChanged: (value) {
                  setState(() {
                    _darkModeEnabled = value;
                  });
                },
              ),
              ListTile(
                title: const Text('Tamaño de fuente'),
                subtitle: Text('${_fontSize.round()}px'),
                trailing: SizedBox(
                  width: 150,
                  child: Slider(
                    value: _fontSize,
                    min: 12.0,
                    max: 24.0,
                    divisions: 6,
                    label: '${_fontSize.round()}px',
                    onChanged: (value) {
                      setState(() {
                        _fontSize = value;
                      });
                    },
                  ),
                ),
              ),
            ]),

            const SizedBox(height: 20),

            // Sección de Idioma
            _buildSectionCard('Idioma y región', Icons.language, [
              ListTile(
                title: const Text('Idioma'),
                subtitle: Text(_selectedLanguage),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _showLanguageSelector();
                },
              ),
            ]),

            const SizedBox(height: 20),

            // Sección de Cuenta
            _buildSectionCard('Cuenta', Icons.account_circle, [
              ListTile(
                title: const Text('Cambiar contraseña'),
                leading: const Icon(Icons.lock_outline),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _showPasswordDialog();
                },
              ),
              ListTile(
                title: const Text('Gestionar datos'),
                leading: const Icon(Icons.storage),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _showDataManagementDialog();
                },
              ),
              ListTile(
                title: const Text('Cerrar sesión'),
                leading: const Icon(Icons.logout, color: Colors.red),
                onTap: () {
                  _showLogoutDialog();
                },
              ),
            ]),

            const SizedBox(height: 20),

            // Sección de Información
            _buildSectionCard('Información', Icons.info, [
              ListTile(
                title: const Text('Versión de la app'),
                subtitle: const Text('1.0.0'),
                leading: const Icon(Icons.info_outline),
              ),
              ListTile(
                title: const Text('Desarrollado por'),
                subtitle: const Text('Estudiante de Programación Móvil'),
                leading: const Icon(Icons.person),
              ),
              ListTile(
                title: const Text('Última actualización'),
                subtitle: const Text('17 de Junio, 2025'),
                leading: const Icon(Icons.update),
              ),
            ]),

            const SizedBox(height: 30),

            // Botones de acción
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  text: 'Guardar',
                  onPressed: _saveSettings,
                  backgroundColor: Colors.green,
                ),
                CustomButton(
                  text: 'Restablecer',
                  onPressed: _resetSettings,
                  backgroundColor: Colors.orange,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Información de estado
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  const Icon(Icons.settings, color: Colors.blue, size: 32),
                  const SizedBox(height: 8),
                  const Text(
                    'Estado de configuración',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Notificaciones: ${_notificationsEnabled ? "Activadas" : "Desactivadas"}\n'
                    'Modo oscuro: ${_darkModeEnabled ? "Activado" : "Desactivado"}\n'
                    'Idioma: $_selectedLanguage',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, IconData icon, List<Widget> children) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).primaryColor),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }

  void _showLanguageSelector() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Seleccionar idioma'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children:
                  _languages.map((language) {
                    return RadioListTile<String>(
                      title: Text(language),
                      value: language,
                      groupValue: _selectedLanguage,
                      onChanged: (value) {
                        setState(() {
                          _selectedLanguage = value!;
                        });
                        Navigator.pop(context);
                      },
                    );
                  }).toList(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
            ],
          ),
    );
  }

  void _showPasswordDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Cambiar contraseña'),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña actual',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Nueva contraseña',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Contraseña actualizada'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: const Text('Actualizar'),
              ),
            ],
          ),
    );
  }

  void _showDataManagementDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Gestionar datos'),
            content: const Text(
              'Opciones para gestionar tus datos:\n\n'
              '• Exportar datos\n'
              '• Eliminar caché\n'
              '• Limpiar historial\n'
              '• Eliminar cuenta',
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

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Cerrar sesión'),
            content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Sesión cerrada'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                },
                child: const Text('Cerrar sesión'),
              ),
            ],
          ),
    );
  }

  void _saveSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Configuración guardada exitosamente'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _resetSettings() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Restablecer configuración'),
            content: const Text(
              '¿Estás seguro de que quieres restablecer toda la configuración '
              'a los valores predeterminados?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _notificationsEnabled = true;
                    _darkModeEnabled = false;
                    _soundEnabled = true;
                    _fontSize = 16.0;
                    _selectedLanguage = 'Español';
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Configuración restablecida'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                },
                child: const Text('Restablecer'),
              ),
            ],
          ),
    );
  }
}
