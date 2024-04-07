import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Responsive layout for different screen sizes
    var size = MediaQuery.of(context).size;
    var isLargeScreen = size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text('Menú Principal'),
        actions: [
          // Buttons or icons for "Menú", "Funciones", "Cuenta" if needed
        ],
      ),
      body: GridView.count(
        padding: EdgeInsets.all(isLargeScreen ? 32.0 : 16.0),
        crossAxisCount: isLargeScreen ? 3 : 2,
        children: [
          _MenuButton(
            image: 'assets/pedidos.png',
            label: 'Pedidos',
            onTap: () => Navigator.pushNamed(context, '/orders'),
          ),
          _MenuButton(
            image: 'assets/agregar_pedido.png', // Añade una imagen para el botón en tus assets
            label: 'Agregar Pedido',
            onTap: () => Navigator.pushNamed(context, '/add_order'),
          ),
          _MenuButton(
            image: 'assets/manual.png',
            label: 'Manual de uso',
            onTap: () => Navigator.pushNamed(context, '/manual'),
          ),
          _MenuButton(
            image: 'assets/descubre_mas.png',
            label: 'Descubre más',
            onTap: () => {}, // Define navigation
          ),
          _MenuButton(
            image: 'assets/soporte_tecnico.png',
            label: 'Soporte técnico',
            onTap: () => Navigator.pushNamed(context, '/support'),
          ),
        ],
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final String image;
  final String label;
  final VoidCallback onTap;

  const _MenuButton({Key? key, required this.image, required this.label, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Image.asset(image, fit: BoxFit.contain),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
