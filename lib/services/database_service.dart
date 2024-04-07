import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/order.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // Lazily instantiate the db the first time it is accessed
    _database = await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    String path = join(await getDatabasesPath(), 'orders_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE orders(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cliente TEXT,
        items TEXT,
        dueDate TEXT
      )
    ''');
  }

  Future<void> insertOrder(Order order) async {
    final db = await database;
    await db.insert(
      'orders',
      order.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Order>> getOrders() async {
    final db = await database;
    final List<Map<String, dynamic>> orderMaps = await db.query('orders');

    return List.generate(orderMaps.length, (i) {
      return Order.fromMap(orderMaps[i]);
    });
  }
  String generateQRData(Order order) {
  final Map<String, dynamic> orderData = {
    'cliente': order.cliente,
    'items': order.items,
    'dueDate': order.dueDate.toIso8601String(), // Convierte la fecha a un string ISO para almacenarla en el QR
  };

  // Convertir los datos del pedido en un string JSON
  return jsonEncode(orderData);
}
}
