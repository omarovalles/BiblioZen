/* Cristopher
Crear formulario para añadir/editar libros
*/
import 'package:app_biblioteca_personal/controllers/libro_controller.dart';
import 'package:flutter/material.dart';
import 'package:app_biblioteca_personal/models/libro.dart';

class LibroFormView extends StatefulWidget {
  final Libro? libro;
  const LibroFormView({Key? key, this.libro}) : super(key: key);

  @override
  _LibroFormViewState createState() => _LibroFormViewState();
}

class _LibroFormViewState extends State<LibroFormView> {
  final _formKey = GlobalKey<FormState>();
  final LibroController libroController = LibroController();

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _autorController = TextEditingController();
  String _generoSelecionado = 'Drama';
  String _estadoSeleccionado = 'No leido';
  late String _fechaRegistro;

  @override
  void initState() {
    super.initState();
    if (widget.libro != null) {
      _tituloController.text = widget.libro!.titulo;
      _autorController.text = widget.libro!.autor;
      _generoSelecionado = widget.libro!.genero;
      _estadoSeleccionado = widget.libro!.estado;
      _fechaRegistro = widget.libro!.fechaRegistro;
    } else {
      _fechaRegistro = DateTime.now().toIso8601String();
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _autorController.dispose();
    super.dispose();
  }

  Future<void> _guardarLibro() async {
    if (_formKey.currentState!.validate()) {
      final libro = Libro(
        id: widget.libro?.id ?? 0,
        titulo: _tituloController.text,
        autor: _autorController.text,
        genero: _generoSelecionado,
        estado: _estadoSeleccionado,
        fechaRegistro: _fechaRegistro,
      );
      if (widget.libro == null) {
        await libroController.agregarLibro(libro);
      } else {
        await libroController.actualizarLibro(libro);
      }
      Navigator.of(context).pop(true); // Regresa a la pantalla anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.libro == null ? 'Agregar Libro' : 'Editar Libro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(labelText: 'Titulo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El titulo es obligatorio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _autorController,
                decoration: const InputDecoration(labelText: 'Autor'),
              ),
              DropdownButtonFormField<String>(
                value: _generoSelecionado,
                decoration: const InputDecoration(labelText: 'Genero'),
                items:
                    ['Drama', 'Ciencia Ficcion', 'Fantasia', 'Terror', 'Otro']
                        .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    _generoSelecionado = value!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: _estadoSeleccionado,
                decoration: const InputDecoration(labelText: 'Estado'),
                items: ['Leido', 'No leido']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _estadoSeleccionado = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _guardarLibro,
                child: Text(
                  widget.libro == null ? 'Agregar' : 'Guardar cambios',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
