import 'package:flutter/material.dart';
import '../models/libro.dart';
import '../views/libro_form_view.dart';
import '../controllers/libro_controller.dart';

class LibroDetailView extends StatelessWidget {
  final Libro libro;
  final LibroController _controller = LibroController();

  LibroDetailView({Key? key, required this.libro}) : super(key: key);

  void _editarLibro(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LibroFormView(libro: libro),
      ),
    );

    // Si se editaron los datos, puedes actualizar la vista o volver
    if (result == true) {
      Navigator.pop(context); // Cerrar la vista detalle y regresar a la lista
    }
  }

  void _eliminarLibro(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('¿Eliminar libro?'),
        content: const Text('Esta acción no se puede deshacer.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await _controller.eliminarLibro(libro.id!);
        Navigator.pop(context); // Volver a la lista
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Libro eliminado')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al eliminar el libro')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(libro.titulo),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Editar',
            onPressed: () => _editarLibro(context),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Eliminar',
            onPressed: () => _eliminarLibro(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Autor: ${libro.autor}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Género: ${libro.genero}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Estado: ${libro.estado ? 'Leído' : 'No leído'}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
