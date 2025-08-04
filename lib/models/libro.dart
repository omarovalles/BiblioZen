/* Juan
*/

class Libro {
  int? id;
  String titulo;
  String autor;
  String genero;
  bool estado;
  DateTime fechaRegistro;

  Libro({
    this.id,
    required this.titulo,
    required this.autor,
    required this.genero,
    required this.estado,
    required this.fechaRegistro,
  });

  Map<String, dynamic> toMap() {
final map = <String, dynamic>{
      'titulo': titulo,
      'autor': autor,
      'genero': genero,
      'estado': estado,
      'fechaRegistro': fechaRegistro.toIso8601String(),
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory Libro.fromMap(Map<String, dynamic> map) {
    return Libro(
      id: map['id'],
      titulo: map['titulo'],
      autor: map['autor'],
      genero: map['genero'],
      estado: map['estado'] == 1,
      fechaRegistro: DateTime.parse(map['fechaRegistro']),
    );
  }
}
