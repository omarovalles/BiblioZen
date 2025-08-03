/* Omar */

import '../db/db_helper.dart';
import '../models/libro.dart';

class LibroController {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  // Obtener todos los libros
  Future<List<Libro>> obtenerLibros() async {
    return await dbHelper.getAllLibros();
  }

  // Insertar un nuevo libro
  Future<void> agregarLibro(Libro libro) async {
    await dbHelper.insertLibro(libro);
  }

  // Actualizar un libro existente
  Future<void> actualizarLibro(Libro libro) async {
    await dbHelper.updateLibro(libro);
  }

  // Eliminar un libro por ID
  Future<void> eliminarLibro(int id) async {
    await dbHelper.deleteLibro(id);
  }

  // Buscar libros por título
  Future<List<Libro>> buscarLibros(String query) async {
    return await dbHelper.searchLibros(query);
  }
}
