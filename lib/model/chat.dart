class Chat {
  final int id;
  final String user;
  final DateTime createdAt;
  final List<Message> messages;

  Chat({
    required this.id,
    required this.user,
    required this.createdAt,
    required this.messages,
  });

  // Factory method to create a Chat object from JSON
  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'],
      user: json['user'],
      createdAt: DateTime.parse(json['created_at']),
      messages: (json['messages'] as List)
          .map((message) => Message.fromJson(message))
          .toList(),
    );
  }

  // Convert a Chat object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'created_at': createdAt.toIso8601String(),
      'messages': messages.map((message) => message.toJson()).toList(),
    };
  }
}

class Message {
  final String sender;
  final String text;
  final DateTime createdAt;

  Message({
    required this.sender,
    required this.text,
    required this.createdAt,
  });

  // Factory method to create a Message object from JSON
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      sender: json['sender'],
      text: json['text'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Convert a Message object to JSON
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'text': text,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
