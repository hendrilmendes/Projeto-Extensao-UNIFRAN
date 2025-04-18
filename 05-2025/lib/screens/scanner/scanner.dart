import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

class ScannerScreen extends StatelessWidget {
  final CameraDescription camera;

  const ScannerScreen({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Escanear')),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<CameraController>(
                future:
                    (() async {
                      final controller = CameraController(
                        camera,
                        ResolutionPreset.medium,
                      );
                      await controller.initialize();
                      return controller;
                    })(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(snapshot.data!);
                  }
                  return const Center(child: CupertinoActivityIndicator());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoButton.filled(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(CupertinoIcons.qrcode_viewfinder),
                    SizedBox(width: 8),
                    Text('Escanear Código'),
                  ],
                ),
                onPressed: () => _simulateScan(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _simulateScan(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder:
          (context) => CupertinoAlertDialog(
            title: const Text('Produto Escaneado'),
            content: const Text(
              'Garrafa de Água\nPlástico PET - 450 anos para decompor',
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
    );
  }
}
