/* Cristopher
Crear formulario para añadir/editar libros
*/
import 'package:app_biblioteca_personal/controllers/libro_controller.dart';
import 'package:flutter/material.dart';
import '../models/libro.dart';

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
  bool leido = false;

  @override
  void initState() {
    super.initState();
    if (widget.libro != null) {
      _tituloController.text = widget.libro!.titulo;
      _autorController.text = widget.libro!.autor;
      _generoSelecionado = widget.libro!.genero;
      leido = widget.libro!.leido;
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
        leido: leido,
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
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El título es obligatorio';
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
                decoration: const InputDecoration(labelText: 'Género'),
                items:
                    ['Drama', 'Ciencia Ficción', 'Fantasía', 'Terror', 'Otro']
                        .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    _generoSelecionado = value!;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('¿Leído?'),
                value: leido,
                onChanged: (value) {
                  setState(() {
                    leido = value;
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
