import 'package:flutter/cupertino.dart';

class WeeklyChallengeScreen extends StatelessWidget {
  const WeeklyChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Desafio da Semana'),
            border: Border(
              bottom: BorderSide(color: CupertinoColors.separator),
            ),
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const Text(
                    'Reduza seu consumo de plástico em 50%',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Evite o uso de copos descartáveis, sacolas plásticas e embalagens de uso único. '
                    'Leve sua própria garrafa reutilizável e sacolas de pano ao sair.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  const CupertinoButton.filled(
                    onPressed: null,
                    child: Text('Marcar como concluído'),
                  ),
                  const SizedBox(height: 32),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
