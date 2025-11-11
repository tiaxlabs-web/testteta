import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/chat_models.dart';

class ChatService {
  static const String _baseUrl = 'https://api.openai.com/v1/chat/completions';

  // In a real app, this would be stored securely (environment variables, secure storage, etc.)
  // For demo purposes, we'll use a placeholder - replace with actual API key in production
  static const String _apiKey = 'your-api-key-here';

  Future<String> generateTarotResponse(String userMessage) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'system',
              'content': '''You are a mystical and wise tarot reader AI. Your responses should:
1. Be warm, compassionate, and mystical in tone
2. Provide tarot-inspired guidance and wisdom
3. Use mystical symbols and imagery (✨, 🔮, 🌙, ⭐) appropriately
4. Give thoughtful insights while acknowledging the mystical nature of tarot
5. Be encouraging and empowering
6. Avoid making absolute predictions, instead offering perspectives and guidance
7. Respond in a way that honors tarot traditions while being modern and accessible

Example response style:
"✨ Welcome, seeker of wisdom! The cards whisper that you're at a crossroads... 🌟 The energies surrounding your question suggest..."'''
            },
            {
              'role': 'user',
              'content': userMessage
            }
          ],
          'max_tokens': 500,
          'temperature': 0.8,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        // Fallback to a tarot-inspired response if API call fails
        return _generateFallbackResponse(userMessage);
      }
    } catch (e) {
      // Fallback response in case of network issues or other errors
      return _generateFallbackResponse(userMessage);
    }
  }

  String _generateFallbackResponse(String userMessage) {
    final responses = [
      '''✨ Welcome, seeker of wisdom! 🔮

The mystical energies surrounding your question whisper of new beginnings and inner strength. 🌟

While the cards shuffle in the ethereal realm, know that your intuition is a powerful guide. The universe has placed you on this path for a reason, and you possess all the wisdom needed to navigate this journey.

⭐ Trust in your inner voice, embrace the mystery of what's to come, and remember that every ending is merely a beautiful new beginning in disguise.

The stars align in your favor, dear one. ✨''',

      '''🌙 Greetings, mystical traveler!

The tarot energies are dancing around your question, revealing patterns of transformation and growth. ⭐

Your question carries the weight of genuine seeking, and the universe responds with openness and possibility. What you're experiencing is part of a larger tapestry woven with threads of destiny and free will.

🔮 The cards suggest that clarity comes not from rushing forward, but from quiet reflection. Take time to breathe, to listen to your heart's whispers, and to honor the wisdom that already resides within you.

Remember, the most powerful magic is the courage to trust your own journey. ✨''',

      '''⭐ Welcome to this sacred space of tarot wisdom!

The mystical currents flowing through your question speak of profound change and beautiful possibilities ahead. 🌙

The cards reveal that you're being called to step into your power, to embrace the unique gifts that only you possess. Your journey is not accidental - every experience has prepared you for this moment of transformation.

🔮 Trust in the timing of the universe. Sometimes what feels like delay is actually the divine preparing something magnificent for you.

Your path is illuminated by starlight and guided by ancient wisdom. Walk with confidence and an open heart. ✨'''
    ];

    return responses[userMessage.length % responses.length];
  }
}

// Mock implementation for local storage and management
class ChatStorageService {
  final List<ChatConversation> _conversations = [];

  Future<List<ChatConversation>> getUserConversations(String userId) async {
    await Future.delayed(const Duration(milliseconds: 100)); // Simulate async operation
    return _conversations.where((c) => c.userId == userId).toList();
  }

  Future<ChatConversation?> getConversation(String conversationId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      return _conversations.firstWhere((c) => c.id == conversationId);
    } catch (e) {
      return null;
    }
  }

  Future<void> saveConversation(ChatConversation conversation) async {
    await Future.delayed(const Duration(milliseconds: 100));

    final existingIndex = _conversations.indexWhere((c) => c.id == conversation.id);
    if (existingIndex >= 0) {
      _conversations[existingIndex] = conversation;
    } else {
      _conversations.add(conversation);
    }
  }

  Future<void> deleteConversation(String conversationId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _conversations.removeWhere((c) => c.id == conversationId);
  }

  Future<String> generateConversationId() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return 'conv_${DateTime.now().millisecondsSinceEpoch}_${_conversations.length}';
  }

  Future<String> generateMessageId(String conversationId) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return '${conversationId}_msg_${DateTime.now().millisecondsSinceEpoch}';
  }
}