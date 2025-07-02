import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../models/usuario.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UsuariosScreen extends StatefulWidget {
  @override
  _UsuariosScreenState createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  List<Usuario> usuarios = [];

  Future<void> cargarUsuarios() async {
    final data = await rootBundle.loadString('assets/data/usuarios.json');
    final List<dynamic> jsonResult = json.decode(data);
    setState(() {
      usuarios = jsonResult.map((e) => Usuario.fromJson(e)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    cargarUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usuarios')),
      body: ListView.builder(
        itemCount: usuarios.length,
        itemBuilder: (context, index) {
          final usuario = usuarios[index];
          return ListTile(
            leading: CachedNetworkImage(
              imageUrl: usuario.avatar,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            title: Text(usuario.nombre),
            subtitle: Text(usuario.email),
          );
        },
      ),
    );
  }
}
