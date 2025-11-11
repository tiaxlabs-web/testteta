class ChatMessage {
  final String id;
  final String text;
  final MessageType type;
  final DateTime timestamp;
  final String? userId;

  ChatMessage({
    required this.id,
    required this.text,
    required this.type,
    required this.timestamp,
    this.userId,
  });

  factory ChatMessage.userMessage({
    required String id,
    required String text,
    required String userId,
  }) {
    return ChatMessage(
      id: id,
      text: text,
      type: MessageType.user,
      timestamp: DateTime.now(),
      userId: userId,
    );
  }

  factory ChatMessage.aiMessage({
    required String id,
    required String text,
  }) {
    return ChatMessage(
      id: id,
      text: text,
      type: MessageType.ai,
      timestamp: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'type': type.toString(),
      'timestamp': timestamp.toIso8601String(),
      'userId': userId,
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      text: json['text'],
      type: MessageType.values.firstWhere((e) => e.toString() == json['type']),
      timestamp: DateTime.parse(json['timestamp']),
      userId: json['userId'],
    );
  }
}

enum MessageType {
  user,
  ai,
}

class ChatConversation {
  final String id;
  final String userId;
  final String title;
  final List<ChatMessage> messages;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChatConversation({
    required this.id,
    required this.userId,
    required this.title,
    required this.messages,
    required this.createdAt,
    required this.updatedAt,
  });

  ChatConversation copyWith({
    String? id,
    String? userId,
    String? title,
    List<ChatMessage>? messages,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ChatConversation(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      messages: messages ?? this.messages,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'messages': messages.map((m) => m.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory ChatConversation.fromJson(Map<String, dynamic> json) {
    return ChatConversation(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      messages: (json['messages'] as List<dynamic>)
          .map((m) => ChatMessage.fromJson(m))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  static ChatConversation createConversation({
    required String id,
    required String userId,
    required String firstMessage,
  }) {
    final now = DateTime.now();
    return ChatConversation(
      id: id,
      userId: userId,
      title: _generateTitle(firstMessage),
      messages: [
        ChatMessage.userMessage(
          id: '${id}_msg_1',
          text: firstMessage,
          userId: userId,
        ),
      ],
      createdAt: now,
      updatedAt: now,
    );
  }

  static String _generateTitle(String firstMessage) {
    if (firstMessage.length <= 30) {
      return firstMessage;
    }
    return '${firstMessage.substring(0, 27)}...';
  }
}