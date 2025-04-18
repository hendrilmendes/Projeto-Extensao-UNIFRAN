import 'package:flutter/material.dart';

class ProductInfoScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductInfoScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product['name'])),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Impacto Ambiental:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(product['impact'], style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 24),
            const Text(
              'Alternativas Sustentáveis:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('Use uma garrafa reutilizável'),
            ),
          ],
        ),
      ),
    );
  }
}
