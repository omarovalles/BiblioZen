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
  bool _estadoSeleccionado = false;
  late DateTime _fechaRegistro;

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
      _fechaRegistro = DateTime.now();
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
        id: widget.libro?.id,
        titulo: _tituloController.text,
        autor: _autorController.text,
        genero: _generoSelecionado,
        estado: _estadoSeleccionado,
        fechaRegistro: _fechaRegistro,
      );

      try {
        if (widget.libro == null) {
          await libroController.agregarLibro(libro);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('📚 Libro agregado con éxito')),
          );
        } else {
          await libroController.actualizarLibro(libro);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('✅ Libro actualizado con éxito')),
          );
        }
        if (!mounted) return;
        Navigator.of(context).pop(true);
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('❌ Error: $e')));
      }
    }
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.deepPurple),
      filled: true,
      fillColor: Colors.deepPurple.shade50,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          widget.libro == null ? '📚 Agregar Libro' : '✏️ Editar Libro',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                "Mi Biblioteca",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade700,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _tituloController,
                decoration: _inputDecoration('Título', Icons.book),
                validator: (value) => value == null || value.isEmpty
                    ? 'El título es obligatorio'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _autorController,
                decoration: _inputDecoration('Autor', Icons.person),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _generoSelecionado,
                decoration: _inputDecoration('Género', Icons.category),
                items:
                    ['Drama', 'Ciencia Ficcion', 'Fantasia', 'Terror', 'Otro']
                        .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                        .toList(),
                onChanged: (value) =>
                    setState(() => _generoSelecionado = value!),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<bool>(
                value: _estadoSeleccionado,
                decoration: _inputDecoration('Estado', Icons.check_circle),
                items: const [
                  DropdownMenuItem(value: true, child: Text('Leído')),
                  DropdownMenuItem(value: false, child: Text('No leído')),
                ],
                onChanged: (value) =>
                    setState(() => _estadoSeleccionado = value!),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                ),
                onPressed: _guardarLibro,
                child: Text(
                  widget.libro == null ? 'Agregar 📖' : 'Guardar cambios 💾',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
