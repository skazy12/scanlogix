import 'package:flutter/material.dart';
import 'package:qr_recognize/screens/add_order_screen.dart';
import 'screens/home_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/scan_screen.dart';
import 'screens/manual_screen.dart';
import 'screens/support_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Scanner App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Define las rutas nombradas.
      routes: {
        '/': (context) => HomeScreen(),
        '/orders': (context) => OrdersScreen(),
        '/scan': (context) => ScanScreen(),
        '/manual': (context) => ManualScreen(),
        '/support': (context) => SupportScreen(),
        '/add_order': (context) => AddOrderScreen(),
      },
    );
  }
}
