import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'views/libro_form_view.dart';
import 'models/libro.dart';

void main() {
  // Inicializa sqflite_common_ffi para PC
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  runApp(MainApp());
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
        '/': (context) => const LibroFormView(),
        '/nuevo': (context) => const LibroFormView(),
        '/editar': (context) {
          final libro = ModalRoute.of(context)!.settings.arguments as Libro?;
          return LibroFormView(libro: libro);
        },
      },
    );
  }
}
