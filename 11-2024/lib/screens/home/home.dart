import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:servicos/screens/report/report.dart';
import 'package:servicos/screens/services_details/services_details.dart';
import 'package:servicos/widgets/search_bar.dart';
import 'package:servicos/widgets/temperature.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController? mapController;
  final Set<Marker> _markers = {};
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _searchQuery = "";
  final List<Marker> _allMarkers = [];
  int _currentTemperature = 0;

  @override
  void initState() {
    super.initState();
    _loadPublicServices();
    _fetchTemperatureForLocation(
        -15.3391487, -58.8738707); // Coordenadas iniciais
  }

  // Função para carregar os serviços públicos do Firestore
  void _loadPublicServices() async {
    final services = await _firestore.collection('public_services').get();
    setState(() {
      _markers.clear();
      _allMarkers.clear();
      for (var service in services.docs) {
        final marker = Marker(
          markerId: MarkerId(service.id),
          position: LatLng(service['latitude'], service['longitude']),
          infoWindow: InfoWindow(
            title: service['name'],
            snippet: service['description'],
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => ServiceDetailsDialog(
                  name: service['name'],
                  contact: service['contact'],
                  hours: service['hours'],
                  description: service['description'],
                ),
              );
            },
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        );
        _markers.add(marker);
        _allMarkers.add(marker);
      }
    });
  }

  void _filterMarkers() {
    setState(() {
      _markers.clear();

      // Filtra os marcadores com base na consulta de pesquisa
      for (var marker in _allMarkers) {
        final serviceName = marker.infoWindow.title ?? "";
        if (serviceName.toLowerCase().contains(_searchQuery.toLowerCase())) {
          _markers.add(marker);
        }
      }
    });
  }

  // Função para buscar a temperatura de uma localização específica
  Future<void> _fetchTemperatureForLocation(
      double latitude, double longitude) async {
    try {
      final temperature = await fetchTemperature(latitude, longitude);
      setState(() {
        _currentTemperature = temperature.toInt();
      });
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao buscar temperatura: $e');
      }
    }
  }

  Future<double> fetchTemperature(double latitude, double longitude) async {
    final url = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current_weather=true');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final temperature = data['current_weather']['temperature'];
      return temperature.toDouble();
    } else {
      throw Exception('Failed to load temperature');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: Text('Denúncias'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              mapController = controller;
            },
            mapType: MapType.satellite,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: LatLng(-15.3391487, -58.8738707),
              zoom: 14.6,
            ),
            markers: _markers,
          ),
          // Widget da barra de pesquisa
          SafeArea(
            child: Column(
              children: [
                SearchBarCustom(
                  onSearch: (value) {
                    _searchQuery = value;
                    _filterMarkers();
                  },
                ),
                // Sugestões de pesquisa
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _searchQuery.isNotEmpty
                      ? Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          constraints: BoxConstraints(
                            maxHeight: 200.0,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: _allMarkers.length,
                            itemBuilder: (context, index) {
                              final serviceName =
                                  _allMarkers[index].infoWindow.title ?? "";
                              final serviceDescription =
                                  _allMarkers[index].infoWindow.snippet ?? "";
                              if (serviceName
                                  .toLowerCase()
                                  .contains(_searchQuery.toLowerCase())) {
                                return ListTile(
                                  title: Text(serviceName),
                                  subtitle: Text(serviceDescription),
                                  onTap: () {
                                    mapController?.animateCamera(
                                      CameraUpdate.newLatLng(
                                          _allMarkers[index].position),
                                    );
                                    setState(() {
                                      _searchQuery = "";
                                    });
                                  },
                                );
                              }
                              return SizedBox.shrink();
                            },
                          ),
                        )
                      : SizedBox.shrink(),
                ),
              ],
            ),
          ),
          // Widget de temperatura flutuante
          TemperatureWidget(temperature: _currentTemperature),
        ],
      ),
    );
  }
}
