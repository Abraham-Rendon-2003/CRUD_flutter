import 'package:flutter/material.dart';
import 'item_model.dart';

class ItemForm extends StatefulWidget {
  final Item? item;
  final Function(Item) onSave;

  ItemForm({this.item, required this.onSave});

  @override
  _ItemFormState createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final _formKey = GlobalKey<FormState>();
  late String id;
  late String marca;
  late String modelo;
  late String tipo;
  late String material;

  @override
  void initState() {
    super.initState();
    id = widget.item?.id ?? '';
    marca = widget.item?.marca ?? '';
    modelo = widget.item?.modelo ?? '';
    tipo = widget.item?.tipo ?? '';
    material = widget.item?.material ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item == null ? 'Agregar Item' : 'Editar Item'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Marca'),
                initialValue: marca,
                onChanged: (value) => marca = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la marca';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Modelo'),
                initialValue: modelo,
                onChanged: (value) => modelo = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el modelo';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tipo'),
                initialValue: tipo,
                onChanged: (value) => tipo = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el tipo';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Material'),
                initialValue: material,
                onChanged: (value) => material = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el material';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final item = Item(
                      id: id.isEmpty ? DateTime.now().toString() : id,
                      marca: marca,
                      modelo: modelo,
                      tipo: tipo,
                      material: material,
                    );
                    widget.onSave(item);
                    Navigator.pop(context);
                  }
                },
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
