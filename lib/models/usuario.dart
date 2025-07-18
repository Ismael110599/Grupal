import 'package:hive/hive.dart';

part 'usuario.g.dart';

@HiveType(typeId: 0)
class Usuario {
  @HiveField(0)
  final String nombre;

  @HiveField(1)
  final int edad;

  Usuario({required this.nombre, required this.edad});
}
