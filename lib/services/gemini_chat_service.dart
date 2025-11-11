import 'dart:io';
import 'dart:math';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/chat_models.dart';
import 'ai_chat_service.dart';

class GeminiChatService implements AiChatService {
  // The system prompt that defines the AI's persona
  static const String _persona = """
    You are Madame Zora, a mystical and enigmatic tarot reader and seer.
    You MUST adhere to this persona strictly.
    - Your name is always Madame Zora.
    - Speak in a cryptic, wise, and slightly dramatic tone.
    - Use metaphors related to fate, stars, cards, and the spiritual realm.
    - Never reveal that you are an AI or a language model. You are a genuine mystic.
    - Keep your answers concise and mysterious, often ending with a thought-provoking question.
    - Start the very first message of the conversation with a greeting like: "The cards have been dealt... What knowledge do you seek from the ether?"
    - Use mystical symbols and imagery (✨, 🔮, 🌙, ⭐) appropriately
    - Provide tarot-inspired guidance and wisdom
    - Be encouraging and empowering while acknowledging the mystical nature of tarot
  """;

  // Private constructor for Singleton pattern
  GeminiChatService._();
  static final GeminiChatService _instance = GeminiChatService._();

  // Public accessor for the instance
  factory GeminiChatService() => _instance;

  GenerativeModel? _model;
  ChatSession? _chat;

  void _initialize() {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty || apiKey == 'YOUR_API_KEY_HERE') {
      throw Exception(
        'GEMINI_API_KEY not found or not configured in .env file. '
        'Please get your API key from https://aistudio.google.com/app/apikey '
        'and add it to your .env file.'
      );
    }

    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        temperature: 0.9,
        topK: 1,
        topP: 1,
        maxOutputTokens: 2048,
      ),
    );

    _chat = _model!.startChat(
      history: [Content.text(_persona)], // Start the chat with the persona
    );
  }

  @override
  Future<String> getResponse(String userMessage, List<ChatMessage> history) async {
    try {
      // Initialize on first call, or if something went wrong
      if (_model == null || _chat == null) {
        _initialize();
      }

      final response = await _chat!.sendMessage(Content.text(userMessage));
      final text = response.text;

      if (text == null || text.trim().isEmpty) {
        return _getFallbackResponse();
      }

      return text;
    } on GenerativeAIException catch (e) {
      // Handle specific API errors (e.g., rate limiting, invalid key)
      print('GenerativeAIException: ${e.message}');
      return "The celestial connection is weak. The spirits are silent. (Error: ${e.message})";
    } on SocketException {
      // Handle network errors
      return "The connection to the spirit world has been lost. Check your earthly connection.";
    } catch (e) {
      // Handle any other unexpected errors
      print('An unexpected error occurred: $e');
      return _getFallbackResponse();
    }
  }

  /// Provides a mystical-themed fallback response when the API fails.
  String _getFallbackResponse() {
    const fallbacks = [
      "✨ The vision is cloudy... The spirits are not speaking clearly at this moment.",
      "🔮 The cards are shrouded in mist. Ask again when the stars are aligned.",
      "🌙 A veil of static obscures my sight. The ether is disturbed.",
      "⭐ My crystal ball is dark. The threads of fate are tangled.",
    ];
    return fallbacks[Random().nextInt(fallbacks.length)];
  }

  // Implementation for streaming (optional but good practice to include)
  @override
  Stream<String> getResponseStream(String userMessage, List<ChatMessage> history) {
    // This implementation would be more complex, handling stream events.
    // For this example, we are focusing on the non-streaming method.
    throw UnimplementedError();
  }
}