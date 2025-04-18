import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sustentabilidade/screens/home/achievements/achievements.dart';
import 'package:sustentabilidade/screens/home/did_you_know/did_you_know.dart';
import 'package:sustentabilidade/screens/home/weekly_challenge/weekly_challenge.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.92);
  int _currentPage = 0;
  Timer? _autoScrollTimer;

  final List<Map<String, String>> _featuredItems = const [
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?auto=format&fit=crop&w=800&q=80',
      'title': 'Economize Água',
      'subtitle': 'Descubra dicas diárias',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1593642532973-d31b6557fa68?auto=format&fit=crop&w=800&q=80',
      'title': 'Recicle Mais',
      'subtitle': 'Aprenda como separar resíduos',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1560807707-8cc77767d783?auto=format&fit=crop&w=800&q=80',
      'title': 'Desafio Verde',
      'subtitle': 'Participe do desafio semanal',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1529070538774-1843cb3265df?auto=format&fit=crop&w=800&q=80',
      'title': 'Energia Sustentável',
      'subtitle': 'Descubra como economizar energia',
    },
  ];

  @override
  void initState() {
    super.initState();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      final next = (_currentPage + 1) % _featuredItems.length;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Início'),
            border: Border(
              bottom: BorderSide(
                color: CupertinoColors.systemGrey.withOpacity(0.3),
              ),
            ),
          ),
          CupertinoSliverRefreshControl(onRefresh: _onRefresh),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: 220,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _featuredItems.length,
                    onPageChanged: (idx) => setState(() => _currentPage = idx),
                    itemBuilder: (context, index) {
                      final item = _featuredItems[index];
                      return _buildFeaturedCard(
                        imageUrl: item['imageUrl']!,
                        title: item['title']!,
                        subtitle: item['subtitle']!,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _featuredItems.length,
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == i ? 12 : 8,
                      height: _currentPage == i ? 12 : 8,
                      decoration: BoxDecoration(
                        color:
                            _currentPage == i
                                ? CupertinoColors.activeBlue
                                : CupertinoColors.systemGrey3,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSectionTile(
                  context,
                  icon: CupertinoIcons.arrow_3_trianglepath,
                  title: 'Desafio da Semana',
                  subtitle: 'Participe e faça a diferença!',
                  onTap:
                      () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => const WeeklyChallengeScreen(),
                        ),
                      ),
                ),
                const Divider(),
                _buildSectionTile(
                  context,
                  icon: CupertinoIcons.lightbulb_fill,
                  title: 'Você Sabia?',
                  subtitle: 'Curiosidades ambientais',
                  onTap:
                      () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => const DidYouKnowScreen(),
                        ),
                      ),
                ),
                const Divider(),
                _buildSectionTile(
                  context,
                  icon: CupertinoIcons.star,
                  title: 'Conquistas',
                  subtitle: 'Veja seu progresso',
                  onTap:
                      () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => const AchievementsScreen(),
                        ),
                      ),
                ),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedCard({
    required String imageUrl,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, left: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              loadingBuilder:
                  (ctx, child, progress) =>
                      progress == null
                          ? child
                          : const CupertinoActivityIndicator(),
              errorBuilder:
                  (ctx, error, stack) => Container(
                    color: CupertinoColors.systemGrey5,
                    child: const Center(
                      child: Icon(
                        CupertinoIcons.photo,
                        size: 48,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  // ignore: deprecated_member_use
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black45,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return CupertinoListTile(
      leading: Icon(icon, color: CupertinoColors.activeBlue),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
      ),
      subtitle: Text(subtitle),
      trailing: const CupertinoListTileChevron(),
      onTap: onTap,
    );
  }
}
