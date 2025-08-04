
class Genero {
  int? id;
  String nombre;

  Genero({this.id, required this.nombre});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
    };
  }

  factory Genero.fromMap(Map<String, dynamic> map) {
    return Genero(
      id: map['id'],
      nombre: map['nombre'],
    );
  }
}
