import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:sustentabilidade/screens/community/community.dart';
import 'package:sustentabilidade/screens/home/home.dart';
import 'package:sustentabilidade/screens/quiz/quiz.dart';
import 'package:sustentabilidade/screens/scanner/scanner.dart';

class MainTabsScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const MainTabsScreen({super.key, required this.cameras});

  @override
  State<MainTabsScreen> createState() => _MainTabsScreenState();
}

class _MainTabsScreenState extends State<MainTabsScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house_fill),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.barcode_viewfinder),
            label: 'Escanear',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chart_bar_alt_fill),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_2_fill),
            label: 'Comunidade',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
      tabBuilder: (context, index) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder:
              (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
          // Atribuímos uma key com base no índice para identificar mudanças no conteúdo
          child: _buildTabContent(index),
        );
      },
    );
  }

  Widget _buildTabContent(int index) {
    // Usamos ValueKey para que o AnimatedSwitcher identifique cada conteúdo como diferente
    switch (index) {
      case 0:
        return CupertinoTabView(
          key: const ValueKey('home'),
          builder: (context) => const HomeScreen(),
        );
      case 1:
        return CupertinoTabView(
          key: const ValueKey('scanner'),
          builder: (context) => ScannerScreen(camera: widget.cameras.first),
        );
      case 2:
        return CupertinoTabView(
          key: const ValueKey('quiz'),
          builder: (context) => const QuizScreen(),
        );
      case 3:
        return CupertinoTabView(
          key: const ValueKey('community'),
          builder: (context) => CommunityScreen(),
        );
      default:
        return CupertinoTabView(
          key: const ValueKey('empty'),
          builder: (context) => const SizedBox.shrink(),
        );
    }
  }
}
