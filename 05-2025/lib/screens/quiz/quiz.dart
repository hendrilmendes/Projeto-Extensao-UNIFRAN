import 'dart:async';
import 'package:flutter/cupertino.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  bool _showFeedback = false;
  Timer? _feedbackTimer;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Qual desses materiais é mais fácil de reciclar?',
      'answers': [
        {'text': 'Plástico PET', 'correct': true},
        {'text': 'Isopor', 'correct': false},
        {'text': 'Papel laminado', 'correct': false},
      ],
    },
    {
      'question':
          'Quantos litros de água são necessários para produzir 1kg de carne bovina?',
      'answers': [
        {'text': '500 litros', 'correct': false},
        {'text': '1.500 litros', 'correct': false},
        {'text': '15.000 litros', 'correct': true},
      ],
    },
  ];

  void _handleAnswer(bool isCorrect) {
    if (!mounted) return;
    setState(() {
      _showFeedback = true;
      if (isCorrect) _correctAnswers++;
    });

    _feedbackTimer = Timer(const Duration(milliseconds: 800), () {
      if (!mounted) return;

      setState(() {
        _showFeedback = false;
      });

      if (_currentQuestionIndex < _questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
        });
      } else {
        _showResultsDialog();
      }
    });
  }

  void _showResultsDialog() {
    if (!mounted) return;
    showCupertinoDialog(
      context: context,
      builder:
          (_) => CupertinoAlertDialog(
            title: const Text('Quiz Completo!'),
            content: Text(
              'Você acertou $_correctAnswers de ${_questions.length} perguntas!',
              style: const TextStyle(fontSize: 18),
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text('Recomeçar'),
                onPressed: () {
                  if (!mounted) return;
                  setState(() {
                    _currentQuestionIndex = 0;
                    _correctAnswers = 0;
                  });
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _feedbackTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final current = _questions[_currentQuestionIndex];

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Quiz Sustentável'),
        border: const Border(bottom: BorderSide()),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Progress Bar
              Container(
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: (_currentQuestionIndex + 1) / _questions.length,
                  child: Container(
                    decoration: BoxDecoration(
                      color: CupertinoColors.activeBlue,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Question Card
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                transitionBuilder:
                    (child, anim) => FadeTransition(
                      opacity: anim,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.1),
                          end: Offset.zero,
                        ).animate(anim),
                        child: child,
                      ),
                    ),
                child: Container(
                  key: ValueKey(_currentQuestionIndex),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: CupertinoColors.black.withOpacity(0.1),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    current['question'],
                    style: CupertinoTheme.of(context)
                        .textTheme
                        .navTitleTextStyle
                        .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Answers
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                child: Column(
                  key: ValueKey(_currentQuestionIndex),
                  children:
                      current['answers'].map<Widget>((ans) {
                        Color btnColor = CupertinoColors.activeBlue;
                        if (_showFeedback && ans['correct']) {
                          btnColor = CupertinoColors.systemGreen;
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: GestureDetector(
                            onTap:
                                _showFeedback
                                    ? null
                                    : () => _handleAnswer(ans['correct']),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 24,
                              ),
                              decoration: BoxDecoration(
                                color: btnColor,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    // ignore: deprecated_member_use
                                    color: btnColor.withOpacity(0.4),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Text(
                                ans['text'],
                                style: CupertinoTheme.of(
                                  context,
                                ).textTheme.textStyle.copyWith(
                                  fontSize: 16,
                                  color: CupertinoColors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),

              // Feedback Icon
              if (_showFeedback)
                const Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Icon(
                    CupertinoIcons.check_mark_circled_solid,
                    color: CupertinoColors.systemGreen,
                    size: 48,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
