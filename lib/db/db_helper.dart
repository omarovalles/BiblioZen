/* Juan
*/

import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import '../models/libro.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('biblioteca.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE generos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE libros (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL,
        autor TEXT NOT NULL,
        genero TEXT NOT NULL,
        estado INTEGER NOT NULL,
        fechaRegistro TEXT NOT NULL
      )
    ''');

    await db.insert('generos', {'nombre': 'Ficción'});
    await db.insert('generos', {'nombre': 'No Ficción'});
  }

  Future<int> insertLibro(Libro libro) async {
    final db = await instance.database;

    final libroMap = libro.toMap();
    libroMap.remove('id'); // importante

    final id = await db.insert('libros', libroMap);
    libro.id = id;
    return id;
  }

  Future<List<Libro>> getAllLibros() async {
    final db = await instance.database;
    final result = await db.query('libros');
    return result.map((map) => Libro.fromMap(map)).toList();
  }

  Future<int> updateLibro(Libro libro) async {
    final db = await instance.database;
    return await db.update(
      'libros',
      libro.toMap(),
      where: 'id = ?',
      whereArgs: [libro.id],
    );
  }

  Future<int> deleteLibro(int id) async {
    final db = await instance.database;
    return await db.delete('libros', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Libro>> searchLibros(String query) async {
    final db = await instance.database;
    final result = await db.query(
      'libros',
      where: 'titulo LIKE ?',
      whereArgs: ['%$query%'],
    );
    return result.map((map) => Libro.fromMap(map)).toList();
  }
}
