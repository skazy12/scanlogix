import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/database_service.dart';
import '../models/order.dart';

class AddOrderScreen extends StatefulWidget {
  @override
  _AddOrderScreenState createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _clienteController = TextEditingController();
  final _itemsController = TextEditingController();
  DateTime? _dueDate;
  final DatabaseService _dbService = DatabaseService();

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _dueDate) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  void _addOrder() async {
    if (_formKey.currentState!.validate() && _dueDate != null) {
      // Divide el string de ítems por las comas y trim para eliminar espacios en blanco.
      List<String> itemsList =
          _itemsController.text.split(',').map((item) => item.trim()).toList();

      // Crear un objeto Order con la lista de ítems
      final order = Order(
        id: null, // Autoincremented by SQLite
        cliente: _clienteController.text,
        items: itemsList,
        dueDate: _dueDate!,
      );
      await _dbService.insertOrder(order);
      Navigator.pop(context); // Return to previous screen
    }
  }


  @override
  void dispose() {
    // Dispose controllers when the widget is removed from the widget tree
    _clienteController.dispose();
    _itemsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Pedido'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _clienteController,
              decoration: InputDecoration(labelText: 'Cliente'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el nombre del cliente';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _itemsController,
              decoration: InputDecoration(
                labelText: 'Items (separados por comas)',
                hintText:
                    'Ejemplo: Audífonos, Cargador tipo C, Funda de celular',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese los ítems del pedido, separados por comas';
                }
                // Puedes añadir más validaciones si es necesario
                return null;
              },
            ),

            ListTile(
              title: Text('Fecha de Envío: ${_dueDate != null ? DateFormat('dd/MM/yyyy').format(_dueDate!) : 'No seleccionada'}'),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _selectDueDate(context),
            ),
            ElevatedButton(
              onPressed: _addOrder,
              child: Text('Agregar Pedido'),
            ),
          ],
        ),
      ),
    );
  }
  
}
