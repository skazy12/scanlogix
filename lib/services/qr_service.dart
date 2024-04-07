import 'dart:convert';

import 'package:qr_recognize/models/order.dart';

class QRService {
  // Método para generar el QR (esto es solo un ejemplo, ajusta según tu implementación)
  String generateQRData(Order order) {
    // Incluye la fecha de envío en el contenido del QR
    final qrData = {
      'id': order.id,
      'cliente': order.cliente,
      'dueDate': order.dueDate.toIso8601String(),
    };
    // Convertir qrData a un string para el QR, p.ej. en formato JSON
    return jsonEncode(qrData);
  }

  // Método para decodificar el QR y verificar la fecha
  bool verifyQR(String qrData) {
    final data = jsonDecode(qrData);
    final dueDate = DateTime.parse(data['dueDate']);
    final currentDate = DateTime.now();
    return dueDate.isAtSameMomentAs(currentDate) || dueDate.isBefore(currentDate);
  }
}
