import 'package:flutter/material.dart';

class WellnessRecommendationsScreen extends StatelessWidget {
  final List<Map<String, String>> recommendations = [
    {
      "text": "Faça uma pausa de 5 minutos para respirar fundo.",
      "image":
          "https://media.istockphoto.com/id/1462659206/pt/foto/portrait-of-a-man-breathing-fresh-air-in-nature.jpg?s=612x612&w=0&k=20&c=n4l6SMi6EZoTvyful7AAN2qxC6mcXlc7PmkTYbssqX4="
    },
    {
      "text": "Beba um copo de água a cada hora.",
      "image":
          "https://images.unsplash.com/photo-1519455953755-af066f52f1a6?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8d2F0ZXJ8ZW58MHx8MHx8fDA%3D"
    },
    {
      "text": "Tire um tempo para meditar ou refletir sobre o dia.",
      "image":
          "https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bWVkaXRhdGV8ZW58MHx8MHx8fDA%3D"
    },
    {
      "text": "Dê uma caminhada leve para relaxar a mente.",
      "image":
          "https://plus.unsplash.com/premium_photo-1690574169354-d6cc4299cf84?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "text": "Evite o uso de dispositivos eletrônicos antes de dormir.",
      "image":
          "https://plus.unsplash.com/premium_photo-1661397087554-2774b7e7332f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8c2xlZXB8ZW58MHx8MHx8fDA%3D"
    },
  ];

  WellnessRecommendationsScreen({super.key});

  // Função para obter a saudação com base na hora do dia
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Bom dia';
    } else if (hour < 18) {
      return 'Boa tarde';
    } else {
      return 'Boa noite';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${_getGreeting()}, ' 'Hendril',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: recommendations.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Background image
                          Image.network(
                            recommendations[index]["image"]!,
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              return Center(
                                  child: Text('Erro ao carregar a imagem'));
                            },
                          ),
                          // Overlay with semi-transparent background
                          Container(
                            color: Colors.black.withOpacity(0.6),
                          ),
                          // Recommendation text
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min, // Ajuste aqui
                              children: [
                                SizedBox(
                                    height:
                                        90), // Ajuste a altura conforme necessário
                                Text(
                                  recommendations[index]["text"]!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black45,
                                        blurRadius: 6,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
