/// Model class representing a chat message.
class ChatModel {
  final int id;
  final String message;
  final String sender;
  final String? comment;
  final int? rating;

  /// Constructor for creating a ChatModel instance.
  ChatModel({
    required this.id,
    required this.message,
    required this.sender,
    this.comment,
    this.rating,
  });

  /// Factory method for creating a ChatModel instance from a JSON map.
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      message: json['message'],
      sender: json['sender'],
      comment: json['comment'],
      rating: json['rating'],
    );
  }

  /// Method for converting a ChatModel instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'sender': sender,
      'comment': comment,
      'rating': rating,
    };
  }

  /// Method for creating a copy of a ChatModel instance with updated fields.
  ChatModel copyWith({
    String? comment,
    int? rating,
  }) {
    return ChatModel(
      id: id,
      message: message,
      sender: sender,
      comment: comment ?? this.comment,
      rating: rating ?? this.rating,
    );
  }
}
