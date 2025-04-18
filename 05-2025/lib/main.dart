// main.dart
import 'package:flutter/cupertino.dart';
import 'package:camera/camera.dart';
import 'package:sustentabilidade/screens/main/main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(SustentaApp(cameras: cameras));
}

class SustentaApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  const SustentaApp({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Sustenta+',
      home: MainTabsScreen(cameras: cameras),
    );
  }
}
