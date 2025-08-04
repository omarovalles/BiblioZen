import 'package:flutter/material.dart';
import '../models/libro.dart';

class LibroDetailView extends StatelessWidget {
  final Libro libro;

  const LibroDetailView({Key? key, required this.libro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(libro.titulo)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Autor: ${libro.autor}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Género: ${libro.genero}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text(
              'Estado: ${libro.estado.toLowerCase() == 'leído' ? 'Leído' : 'No leído'}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
