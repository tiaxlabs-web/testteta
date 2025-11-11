import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/mystical_background.dart';
import 'tarot_reading_screen.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentIndex = 0;

  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AuthProvider>();

    return Scaffold(
      body: MysticalBackground(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: const [
            // Tarot Reading Screen (Index 0)
            TarotReadingWrapper(),
            // Chat Screen (Index 1)
            ChatWrapper(),
          ],
        ),
      ),
      // Floating navigation bar
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AnimatedBuilder(
        animation: _glowAnimation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.5 * _glowAnimation.value),
                  blurRadius: 20,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/chat_history');
              },
              backgroundColor: Colors.purple.shade600,
              elevation: 8,
              child: const Icon(
                Icons.history,
                color: Colors.white,
                size: 28,
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.black.withOpacity(0.5),
          border: Border.all(
            color: Colors.purple.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(0.6),
            selectedFontSize: 12,
            unselectedFontSize: 11,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.auto_awesome),
                activeIcon: Icon(Icons.auto_awesome),
                label: 'Tarot',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                activeIcon: Icon(Icons.chat),
                label: 'AI Chat',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Wrapper widgets for each page to avoid circular imports
class TarotReadingWrapper extends StatelessWidget {
  const TarotReadingWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Import and use the TarotReadingScreen here
    // This avoids circular import issues
    return const TarotReadingScreen();
  }
}

class ChatWrapper extends StatelessWidget {
  const ChatWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to the chat screen without arguments (new conversation)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, '/chat');
    });
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: Colors.purple),
      ),
    );
  }
}