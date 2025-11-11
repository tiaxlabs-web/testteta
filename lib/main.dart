import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'models/chat_models.dart';
import 'screens/login_screen.dart';
import 'screens/tarot_reading_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/chat_history_screen.dart';
import 'screens/main_nav_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider()..initialize(),
      child: MaterialApp(
        title: 'Tarot Reading App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => const AuthWrapper(),
          '/login': (context) => const LoginScreen(),
          '/main': (context) => const MainNavScreen(),
          '/tarot': (context) => const TarotReadingScreen(),
          '/chat': (context) => ChatScreen(),
          '/chat_history': (context) => const ChatHistoryScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/chat' && settings.arguments != null) {
            return MaterialPageRoute(
              builder: (context) => ChatScreen(conversation: settings.arguments as ChatConversation),
            );
          }
          return null;
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        // Show loading while checking auth state
        if (authProvider.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Show main navigation if authenticated, otherwise show login
        if (authProvider.isAuthenticated) {
          return const MainNavScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
