class Usuario {
  final int id;
  final String nombre;
  final String email;
  final String avatar;

  Usuario({
    required this.id,
    required this.nombre,
    required this.email,
    required this.avatar,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nombre: json['nombre'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }
}
