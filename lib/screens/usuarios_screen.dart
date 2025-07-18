import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/usuario.dart';

class UsuariosScreen extends StatefulWidget {
  const UsuariosScreen({super.key});

  @override
  State<UsuariosScreen> createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  final nameCtrl = TextEditingController();
  final ageCtrl = TextEditingController();

  void _addUsuario() async {
    final box = Hive.box<Usuario>('usuarios');
    final nombre = nameCtrl.text.trim();
    final edad = int.tryParse(ageCtrl.text) ?? 0;
    if (nombre.isNotEmpty) {
      await box.add(Usuario(nombre: nombre, edad: edad));
      nameCtrl.clear();
      ageCtrl.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final usuarios = Hive.box<Usuario>('usuarios').values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Usuarios")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),
            TextField(
              controller: ageCtrl,
              decoration: const InputDecoration(labelText: "Edad"),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: _addUsuario,
              child: const Text("Guardar"),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: usuarios.length,
                itemBuilder:
                    (_, i) => ListTile(
                      title: Text(usuarios[i].nombre),
                      subtitle: Text("Edad: ${usuarios[i].edad}"),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
