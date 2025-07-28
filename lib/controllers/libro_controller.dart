/* Omar
*/

import '../db/db_helperfake.dart';
import '../models/fakemodel.dart';


class LibroController {
  final DBHelperFake dbHelper = DBHelperFake();

  // Obtener todos los libros
  Future<List<Libro>> obtenerLibros() async {
    return await dbHelper.getLibros();
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
}

