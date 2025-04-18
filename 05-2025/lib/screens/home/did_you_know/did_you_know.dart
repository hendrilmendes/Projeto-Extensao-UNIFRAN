import 'package:flutter/cupertino.dart';

class DidYouKnowScreen extends StatelessWidget {
  const DidYouKnowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Você Sabia?'),
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
                    'Uma garrafa plástica pode levar até 450 anos para se decompor.',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'O plástico é um dos maiores poluentes dos oceanos e representa uma ameaça significativa à vida marinha.',
                    style: TextStyle(fontSize: 16),
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
