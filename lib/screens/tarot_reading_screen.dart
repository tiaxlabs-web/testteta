import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/tarot_card.dart';
import '../providers/auth_provider.dart';

class TarotReadingScreen extends StatefulWidget {
  const TarotReadingScreen({super.key});

  @override
  State<TarotReadingScreen> createState() => _TarotReadingScreenState();
}

class _TarotReadingScreenState extends State<TarotReadingScreen>
    with SingleTickerProviderStateMixin {
  TarotCard? _selectedCard;
  bool _isReversed = false;
  bool _isAnimating = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _drawCard() {
    if (_isAnimating) return;

    setState(() {
      _isAnimating = true;
      _selectedCard = null;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      final random = Random();
      final card = TarotData.majorArcana[random.nextInt(TarotData.majorArcana.length)];
      final reversed = random.nextBool();

      setState(() {
        _selectedCard = card;
        _isReversed = reversed;
        _isAnimating = false;
      });

      _animationController.forward(from: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.currentUser;

    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: const Text('Tarot Reading'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authProvider.logout();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Welcome message
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Welcome, ${user?.name ?? "User"}!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple[800],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Draw a card to receive your daily guidance',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.deepPurple[400],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Card display area
              if (_selectedCard != null)
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.deepPurple[100]!,
                            Colors.deepPurple[50]!,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          // Card emoji
                          Transform.rotate(
                            angle: _isReversed ? pi : 0,
                            child: Text(
                              _selectedCard!.emoji,
                              style: const TextStyle(fontSize: 80),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Card name
                          Text(
                            _selectedCard!.name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple[800],
                            ),
                            textAlign: TextAlign.center,
                          ),

                          // Orientation badge
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _isReversed
                                  ? Colors.orange[100]
                                  : Colors.green[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _isReversed ? 'Reversed' : 'Upright',
                              style: TextStyle(
                                color: _isReversed
                                    ? Colors.orange[900]
                                    : Colors.green[900],
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Description
                          Text(
                            _selectedCard!.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.deepPurple[600],
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),

                          // Meaning
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Meaning:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple[800],
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _isReversed
                                      ? _selectedCard!.reversedMeaning
                                      : _selectedCard!.meaning,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.deepPurple[200]!,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          size: 80,
                          color: Colors.deepPurple[200],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Draw a card to begin',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 32),

              // Draw card button
              SizedBox(
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _isAnimating ? null : _drawCard,
                  icon: _isAnimating
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.shuffle),
                  label: Text(
                    _selectedCard == null ? 'Draw Your Card' : 'Draw Another Card',
                    style: const TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
