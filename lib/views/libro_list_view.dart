import 'package:flutter/material.dart';
import '../controllers/libro_controller.dart';
import '../widgets/libro_card.dart';

class LibroListView extends StatefulWidget {
  const LibroListView({Key? key}) : super(key: key);

  @override
  _LibroListViewState createState() => _LibroListViewState();
}

class _LibroListViewState extends State<LibroListView> {
  final LibroController _controller = LibroController();

  @override
  void initState() {
    super.initState();
    _controller.cargarLibros();
  }

  @override
  Widget build(BuildContext context) {
    final libros = _controller.libros;

    return Scaffold(
      appBar: AppBar(title: const Text('Mi Biblioteca')),
      body: ListView.builder(
        itemCount: libros.length,
        itemBuilder: (context, index) {
          return LibroCard(libro: libros[index]);
        },
      ),
    );
  }
}