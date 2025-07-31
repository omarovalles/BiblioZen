/* Juan
*/
class Libro {
  int? id;
  String titulo;
  String autor;
  String genero;
  String estado;
  String fechaRegistro;

  Libro({
    this.id,
    required this.titulo,
    required this.autor,
    required this.genero,
    required this.estado,
    required this.fechaRegistro,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'autor': autor,
      'genero': genero,
      'estado': estado,
      'fechaRegistro': fechaRegistro,
    };
  }

  factory Libro.fromMap(Map<String, dynamic> map) {
    return Libro(
      id: map['id'],
      titulo: map['titulo'],
      autor: map['autor'],
      genero: map['genero'],
      estado: map['estado'],
      fechaRegistro: map['fechaRegistro'],
    );
  }
}
