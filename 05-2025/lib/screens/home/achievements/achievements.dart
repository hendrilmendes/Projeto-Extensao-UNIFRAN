import 'package:flutter/cupertino.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Conquistas'),
            border: Border(
              bottom: BorderSide(color: CupertinoColors.separator),
            ),
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 16),
                _buildAchievementTile(
                  icon: CupertinoIcons.star_fill,
                  title: 'Primeira Conquista!',
                  subtitle: 'Você completou seu primeiro desafio.',
                  unlocked: true,
                ),
                _buildAchievementTile(
                  icon: CupertinoIcons.heart_fill,
                  title: 'Coração Verde',
                  subtitle: 'Participou de 5 desafios ecológicos.',
                  unlocked: true,
                ),
                _buildAchievementTile(
                  icon: CupertinoIcons.leaf_arrow_circlepath,
                  title: 'Eco-Guerreiro',
                  subtitle: 'Completou 10 desafios sustentáveis.',
                  unlocked: false,
                ),
                _buildAchievementTile(
                  icon: CupertinoIcons.bolt,
                  title: 'Impacto Positivo',
                  subtitle: 'Compartilhou dicas com 5 amigos.',
                  unlocked: false,
                ),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildAchievementTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool unlocked,
  }) {
    return Opacity(
      opacity: unlocked ? 1.0 : 0.4,
      child: CupertinoListTile(
        leading: Icon(
          icon,
          color:
              unlocked
                  ? CupertinoColors.activeGreen
                  : CupertinoColors.inactiveGray,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing:
            unlocked
                ? const Icon(
                  CupertinoIcons.check_mark_circled_solid,
                  color: CupertinoColors.systemGreen,
                )
                : const Icon(
                  CupertinoIcons.lock,
                  color: CupertinoColors.systemGrey,
                ),
        onTap: () {},
      ),
    );
  }
}
