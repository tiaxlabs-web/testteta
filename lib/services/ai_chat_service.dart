import '../models/chat_models.dart';

/// Abstract base class for an AI Chat Service.
/// This allows for interchangeable AI implementations (e.g., Gemini, OpenAI).
abstract class AiChatService {
  /// Sends a user message and the conversation history to the AI,
  /// and returns the AI's response as a stream of text.
  Stream<String> getResponseStream(String userMessage, List<ChatMessage> history);

  /// A simpler method for non-streaming responses.
  Future<String> getResponse(String userMessage, List<ChatMessage> history);
}