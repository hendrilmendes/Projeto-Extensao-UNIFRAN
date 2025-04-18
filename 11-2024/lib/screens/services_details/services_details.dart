import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceDetailsDialog extends StatelessWidget {
  final String name;
  final String contact;
  final String hours;
  final String description;

  const ServiceDetailsDialog({
    super.key,
    required this.name,
    required this.contact,
    required this.hours,
    required this.description,
  });

  // Função para abrir o discador com o número de telefone
  void _launchCaller(String contact, BuildContext context) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: contact);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível realizar a ligação para $contact')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Row(
        children: [
          Icon(Icons.local_hospital, color: Colors.blueAccent, size: 30),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: Colors.grey[400]),
            Text('Contato:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            InkWell(
              onTap: () => _launchCaller(contact, context),
              child: Row(
                children: [
                  Icon(Icons.phone, color: Colors.green, semanticLabel: 'Número de telefone'),
                  SizedBox(width: 8),
                  Text(contact,
                      style: TextStyle(fontSize: 18, color: Colors.blue)),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text('Horário de Atendimento:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(
              hours,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text('Descrição:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(description, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text('Fechar', style: TextStyle(color: Colors.white)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
