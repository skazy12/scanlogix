class Order {
  //el id puede ser null, ya que es autoincremental
  final int? id;
  final String cliente;
  final List<String> items;
  final DateTime dueDate; // Fecha prevista de envío

  Order({required this.id, required this.cliente, required this.items, required this.dueDate});

  // ...

  Map<String, dynamic> toMap() {
    return {
      //el id puede ser null, ya que es autoincremental
      'id': id,
      'cliente': cliente,
      'items': items.join(', '), // Unir los items con comas
      'dueDate': dueDate.toIso8601String(), // Guardar la fecha en formato ISO
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      cliente: map['cliente'],
      items: map['items'].split(', '), // Dividir el string de items
      dueDate: DateTime.parse(map['dueDate']), // Convertir el string ISO en DateTime
    );
  }
}
