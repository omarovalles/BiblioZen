class Libro {
int? id;
String titulo;
String autor;
String genero;
bool leido;

Libro({
this.id,
required this.titulo,
required this.autor,
required this.genero,
this.leido = false,
});

// Método para convertir un objeto Libro a mapa (útil si luego quieres usar SQLite real)
Map<String, dynamic> toMap() {
return {
'id': id,
'titulo': titulo,
'autor': autor,
'genero': genero,
'leido': leido ? 1 : 0, // SQLite no tiene booleanos, se usa 1 y 0
};
}

// Método para crear un objeto Libro desde un mapa
factory Libro.fromMap(Map<String, dynamic> map) {
return Libro(
id: map['id'],
titulo: map['titulo'],
autor: map['autor'],
genero: map['genero'],
leido: map['leido'] == 1, // convertir de 1/0 a bool
);
}
}