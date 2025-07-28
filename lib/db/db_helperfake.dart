// lib/db/db_helper_fake.dart

import '../models/fakemodel.dart';

class DBHelperFake {
// Simula una tabla de libros
List<Libro> _libros = [
Libro(id: 1, titulo: '1984', autor: 'George Orwell', genero: 'Ficción', leido: true),
Libro(id: 2, titulo: 'Clean Code', autor: 'Robert C. Martin', genero: 'Técnico', leido: false),
];

// Obtener todos los libros
Future<List<Libro>> getLibros() async {
await Future.delayed(Duration(milliseconds: 200)); // simula retraso de base de datos
return _libros;
}

// Insertar un nuevo libro
Future<void> insertLibro(Libro libro) async {
await Future.delayed(Duration(milliseconds: 200));
libro.id = _libros.length + 1; // asigna ID automáticamente
_libros.add(libro);
}

// Actualizar libro existente
Future<void> updateLibro(Libro libro) async {
await Future.delayed(Duration(milliseconds: 200));
int index = _libros.indexWhere((l) => l.id == libro.id);
if (index != -1) {
_libros[index] = libro;
}
}

// Eliminar libro por ID
Future<void> deleteLibro(int id) async {
await Future.delayed(Duration(milliseconds: 200));
_libros.removeWhere((l) => l.id == id);
}
}