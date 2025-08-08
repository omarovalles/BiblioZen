import 'package:flutter/material.dart';
import 'models/libro.dart';
import 'views/libro_list_view.dart';
import 'views/libro_form_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Si usas sqflite_common_ffi para Windows, inicialízalo aquí también
  // sqfliteFfiInit();
  // databaseFactory = databaseFactoryFfi;

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biblioteca Personal',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LibroListView(), // Pantalla principal lista
        '/nuevoLibro': (context) => const LibroFormView(), // Para agregar libro
        '/editarLibro': (context) {
          final libro = ModalRoute.of(context)!.settings.arguments as Libro?;
          return LibroFormView(libro: libro); // Para editar libro
        },
      },
    );
  }
}
