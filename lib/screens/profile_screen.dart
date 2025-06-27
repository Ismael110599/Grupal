import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDarkMode = false;
  int _experienceLevel = 1;
  final List<String> _skills = ['Flutter', 'Dart', 'Firebase', 'Git'];
  final TextEditingController _newSkillController = TextEditingController();
  Color _profileColor = Colors.deepPurple;
  bool _isOnline = true;

  final List<Color> _availableColors = [
    Colors.deepPurple,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.teal,
  ];

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _changeExperienceLevel() {
    setState(() {
      _experienceLevel = _experienceLevel < 5 ? _experienceLevel + 1 : 1;
    });
  }

  void _addNewSkill() {
    if (_newSkillController.text.isNotEmpty) {
      setState(() {
        _skills.add(_newSkillController.text);
        _newSkillController.clear();
      });
    }
  }

  void _removeSkill(int index) {
    setState(() {
      _skills.removeAt(index);
    });
  }

  void _changeProfileColor() {
    setState(() {
      int currentIndex = _availableColors.indexOf(_profileColor);
      _profileColor =
          _availableColors[(currentIndex + 1) % _availableColors.length];
    });
  }

  void _toggleOnlineStatus() {
    setState(() {
      _isOnline = !_isOnline;
    });
  }

  String _getExperienceLevelText() {
    switch (_experienceLevel) {
      case 1:
        return 'Principiante';
      case 2:
        return 'Básico';
      case 3:
        return 'Intermedio';
      case 4:
        return 'Avanzado';
      case 5:
        return 'Experto';
      default:
        return 'Principiante';
    }
  }

  @override
  void dispose() {
    _newSkillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        backgroundColor: _profileColor,
        title: Text(
          'Mi Perfil',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: _toggleDarkMode,
            tooltip: 'Cambiar tema',
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: _toggleOnlineStatus,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _isOnline ? Icons.circle : Icons.circle_outlined,
                    color: _isOnline ? Colors.green : Colors.red,
                    size: 12,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _isOnline ? 'En línea' : 'Desconectado',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: _profileColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -40,
                  child: GestureDetector(
                    onTap: _changeProfileColor,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            _profileColor.withOpacity(0.7),
                            _profileColor,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(
                          color: _isOnline ? Colors.green : Colors.red,
                          width: 4,
                        ),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),

            Text(
              'Estudiante Flutter',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: _isDarkMode ? Colors.white : Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem(Icons.star, 'Nivel', '$_experienceLevel/5'),
                _buildStatItem(Icons.code, 'Skills', '${_skills.length}'),
                _buildStatItem(
                  Icons.circle,
                  'Estado',
                  _isOnline ? 'Online' : 'Off',
                ),
              ],
            ),

            const SizedBox(height: 20),

            GestureDetector(
              onTap: _changeExperienceLevel,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _profileColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _profileColor),
                ),
                child: Text(
                  'Nivel: ${_getExperienceLevelText()} ($_experienceLevel/5) - Toca para cambiar',
                  style: TextStyle(
                    fontSize: 14,
                    color: _isDarkMode ? Colors.white : _profileColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
            _buildInfoCard('Información Personal', [
              _buildInfoRow(Icons.email, 'Email', 'estudiante@universidad.edu'),
              _buildInfoRow(Icons.phone, 'Teléfono', '+593 99 123 4567'),
              _buildInfoRow(Icons.location_on, 'Ubicación', 'Quito, Ecuador'),
              _buildInfoRow(Icons.school, 'Universidad', 'Mi Universidad'),
            ]),

            const SizedBox(height: 20),
            _buildSkillsCard(),

            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  text: 'Cambiar Tema',
                  onPressed: _toggleDarkMode,
                  backgroundColor: _isDarkMode ? Colors.orange : Colors.blue,
                ),
                CustomButton(
                  text: 'Estado',
                  onPressed: _toggleOnlineStatus,
                  backgroundColor: _isOnline ? Colors.red : Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: 'Regresar al Inicio',
                onPressed: () {
                  Navigator.pop(context);
                },
                backgroundColor: _profileColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      elevation: 4,
      color: _isDarkMode ? Colors.grey[800] : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _isDarkMode ? Colors.white : _profileColor,
              ),
            ),
            const SizedBox(height: 15),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsCard() {
    return Card(
      elevation: 4,
      color: _isDarkMode ? Colors.grey[800] : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Habilidades Técnicas (${_skills.length})',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _isDarkMode ? Colors.white : _profileColor,
              ),
            ),
            const SizedBox(height: 15),
            ...List.generate(_skills.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: _profileColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _profileColor.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          _skills[index],
                          style: TextStyle(
                            fontSize: 14,
                            color: _isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () => _removeSkill(index),
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 20,
                      ),
                      tooltip: 'Eliminar habilidad',
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _newSkillController,
                    style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Nueva habilidad...',
                      hintStyle: TextStyle(
                        color:
                            _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: _profileColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: _profileColor, width: 2),
                      ),
                    ),
                    onSubmitted: (_) => _addNewSkill(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _addNewSkill,
                  icon: Icon(Icons.add, color: _profileColor),
                  tooltip: 'Agregar habilidad',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: _profileColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: _profileColor, size: 28),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: _isDarkMode ? Colors.white70 : Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _isDarkMode ? Colors.white : _profileColor,
          ),
        ),
      ],
    );
  }
}
