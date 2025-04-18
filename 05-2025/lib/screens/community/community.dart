import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  static final List<Map<String, dynamic>> _defaultPosts = List.unmodifiable([
    {
      'author': 'Alice',
      'content': 'Acabei de adotar um estilo de vida mais sustentável!',
      'likes': 15,
      'time': '2h atrás',
    },
    {
      'author': 'Bruno',
      'content': 'Participei do plantio de árvores na comunidade.',
      'likes': 22,
      'time': '5h atrás',
    },
    {
      'author': 'Carla',
      'content': 'Reduzi meu consumo de plástico e estou me sentindo incrível.',
      'likes': 8,
      'time': '1d atrás',
    },
    {
      'author': 'Diego',
      'content': 'Juntos podemos transformar nosso bairro em um exemplo de sustentabilidade!',
      'likes': 30,
      'time': '2d atrás',
    },
  ]);

  final List<Map<String, dynamic>> posts;

  CommunityScreen({super.key, List<Map<String, dynamic>>? posts})
      : posts = (posts != null && posts.isNotEmpty) ? posts : _defaultPosts;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Comunidade'),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.add_circled),
              onPressed: () => _showNewPostDialog(context),
            ),
          ),
          posts.isEmpty
              ? SliverFillRemaining(
                  child: _buildEmptyState(),
                )
              : _buildSliverPostsList(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.doc_plaintext,
            size: 64,
            color: CupertinoColors.systemGrey,
          ),
          SizedBox(height: 16),
          Text(
            'Nenhum post disponível\nSeja o primeiro a compartilhar!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: CupertinoColors.systemGrey),
          ),
        ],
      ),
    );
  }

  SliverList _buildSliverPostsList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: _PostItem(post: posts[index]),
          );
        },
        childCount: posts.length,
      ),
    );
  }

  void _showNewPostDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Novo Post'),
        content: CupertinoTextField(
          controller: controller,
          placeholder: 'Compartilhe sua conquista...',
          maxLines: 3,
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: const Text('Postar'),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                // Lógica para adicionar novo post
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _PostItem extends StatelessWidget {
  final Map<String, dynamic> post;

  const _PostItem({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
        color: CupertinoColors.systemBackground.resolveFrom(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAuthorRow(),
          const SizedBox(height: 12),
          Text(
            post['content'],
            style: const TextStyle(fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 12),
          _buildInteractionRow(),
        ],
      ),
    );
  }

  Widget _buildAuthorRow() {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
            'https://ui-avatars.com/api/?name=${Uri.encodeComponent(post['author'])}&background=random',
          ),
          backgroundColor: CupertinoColors.systemGrey5,
          onBackgroundImageError: (_, __) => const Icon(
            CupertinoIcons.person_fill,
            color: CupertinoColors.systemGrey,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post['author'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                post['time'] ?? 'Agora há pouco',
                style: const TextStyle(
                  fontSize: 12,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(CupertinoIcons.ellipsis),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildInteractionRow() {
    return Row(
      children: [
        Icon(
          CupertinoIcons.heart_fill,
          size: 18,
          color: CupertinoColors.systemRed.withOpacity(0.8),
        ),
        const SizedBox(width: 6),
        Text(
          '${post['likes']} curtidas',
          style: const TextStyle(
            fontSize: 14,
            color: CupertinoColors.systemGrey,
          ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(CupertinoIcons.share_up),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(CupertinoIcons.chat_bubble),
          onPressed: () {},
        ),
      ],
    );
  }
}
