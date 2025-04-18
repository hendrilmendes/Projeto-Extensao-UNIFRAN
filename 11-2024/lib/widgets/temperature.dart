import 'package:flutter/material.dart';

class TemperatureWidget extends StatelessWidget {
  final int temperature;

  const TemperatureWidget({super.key, required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 80,
      right: 16,
      child: GestureDetector(
        onTap: () {
          _showTemperatureInfo(context);
        },
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 8.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.thermostat, color: Colors.white, size: 28),
              SizedBox(width: 8),
              Text(
                '$temperature°C',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(
                      blurRadius: 4.0,
                      color: Colors.black45,
                      offset: Offset(1, 2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTemperatureInfo(BuildContext context) {
    String message;
    Icon icon;

    if (temperature > 30) {
      message =
          'Temperatura alta! Beba bastante água e evite exposição prolongada ao sol.';
      icon = Icon(Icons.wb_sunny, color: Colors.orange, size: 48);
    } else if (temperature < 10) {
      message = 'Temperatura baixa! Vista-se bem e mantenha-se aquecido.';
      icon = Icon(Icons.ac_unit, color: Colors.lightBlue, size: 48);
    } else {
      message =
          'Temperatura agradável! Aproveite o dia, mas sempre mantenha-se hidratado.';
      icon = Icon(Icons.cloud, color: Colors.blueGrey, size: 48);
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Row(
            children: [
              icon,
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Informações de Saúde',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
