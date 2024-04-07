import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatear las fechas
import '../models/order.dart';
import '../services/database_service.dart';

class OrdersScreen extends StatelessWidget {
  final DatabaseService dbService = DatabaseService();
  final DateFormat dateFormatter = DateFormat('dd/MM/yyyy'); // Ajusta el formato de fecha según necesites

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // TODO: Agrega aquí la lógica para actualizar la lista de pedidos
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Order>>(
        future: dbService.getOrders(), // Suponiendo que este método devuelva todos los pedidos
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay pedidos disponibles.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var order = snapshot.data![index];
                var dueDate = dateFormatter.format(order.dueDate);
                var isDueToday = order.dueDate.isAtSameMomentAs(DateTime.now());
                var dueString = isDueToday ? "Hoy" : "Envío: $dueDate";

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: ListTile(
                    title: Text('Pedido ${order.id}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Cliente: ${order.cliente}'),
                        ...order.items.map((item) => Text('- $item')).toList(),
                        Text(dueString),
                      ],
                    ),
                    trailing: isDueToday
                        ? Icon(Icons.check_circle, color: Colors.green)
                        : Icon(Icons.access_time, color: Colors.red),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
