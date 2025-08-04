import 'package:flutter/material.dart';
import '../models/libro.dart';
import '../views/libro_detail_view.dart';

class LibroCard extends StatelessWidget {
  final Libro libro;

  const LibroCard({Key? key, required this.libro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(libro.titulo),
        subtitle: Text(libro.autor),
        trailing: Icon(
          libro.estado ? Icons.check_circle : Icons.radio_button_unchecked,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LibroDetailView(libro: libro),
            ),
          );
        },
      ),
    );
  }
}
