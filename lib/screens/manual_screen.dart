import 'package:flutter/material.dart';

class ManualScreen extends StatelessWidget {
  const ManualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manual de Uso'),
      ),
      body: Center(
        child: Text('Contenido del Manual de Uso'),
      ),
    );
  }
}
