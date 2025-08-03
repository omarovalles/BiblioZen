/* Omar - GeneroController */

import '../db/db_helper.dart';
import '../models/genero.dart';

class GeneroController {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  // Obtener todos los géneros
  Future<List<Genero>> obtenerGeneros() async {
    final db = await dbHelper.database;
    final result = await db.query('generos');
    return result.map((map) => Genero.fromMap(map)).toList();
  }

  // Insertar un nuevo género
  Future<void> agregarGenero(Genero genero) async {
    final db = await dbHelper.database;
    await db.insert('generos', genero.toMap());
  }

  // Actualizar un género existente
  Future<void> actualizarGenero(Genero genero) async {
    final db = await dbHelper.database;
    await db.update(
      'generos',
      genero.toMap(),
      where: 'id = ?',
      whereArgs: [genero.id],
    );
  }

  // Eliminar un género por ID
  Future<void> eliminarGenero(int id) async {
    final db = await dbHelper.database;
    await db.delete('generos', where: 'id = ?', whereArgs: [id]);
  }

  // Buscar géneros por nombre
  Future<List<Genero>> buscarGeneros(String query) async {
    final db = await dbHelper.database;
    final result = await db.query(
      'generos',
      where: 'nombre LIKE ?',
      whereArgs: ['%$query%'],
    );
    return result.map((map) => Genero.fromMap(map)).toList();
  }
}
