import 'package:flutter/material.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escanear'),
      ),
      body: Center(
        child: Text('Pantalla de Escaneo de QR'),
      ),
    );
  }
}
