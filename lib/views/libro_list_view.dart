import 'package:flutter/material.dart';
import '../controllers/libro_controller.dart';
import '../widgets/libro_card.dart';
import '../models/libro.dart';

class LibroListView extends StatefulWidget {
  const LibroListView({Key? key}) : super(key: key);

  @override
  _LibroListViewState createState() => _LibroListViewState();
}

class _LibroListViewState extends State<LibroListView> {
  final LibroController _controller = LibroController();
  List<Libro> _libros = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cargarLibros();
  }

  Future<void> _cargarLibros() async {
    final libros = await _controller.obtenerLibros();
    setState(() {
      _libros = libros;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi Biblioteca')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                final resultado = await Navigator.pushNamed(
                  context,
                  '/nuevoLibro',
                );
                if (resultado == true) {
                  _cargarLibros();
                }
              },
              child: Text('Agregar Libro'),
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _libros.isEmpty
                ? Center(child: Text('No hay libros disponibles'))
                : ListView.builder(
                    itemCount: _libros.length,
                    itemBuilder: (context, index) {
                      return LibroCard(
                        libro: _libros[index],
                        onRefresh: _cargarLibros,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
