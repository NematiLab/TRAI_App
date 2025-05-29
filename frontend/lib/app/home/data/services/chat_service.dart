import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/app/home/data/model/chat_model.dart';
import 'package:frontend/config.dart';
import 'package:frontend/core/dependency_injection/clients/dio_client.dart';
import 'package:frontend/core/dependency_injection/dependency_injection.dart';
import 'package:logger/logger.dart';

/// Service class for handling chat-related operations.
class ChatService extends ChangeNotifier {
  final Logger logger = Logger();

  /// Fetches chat messages based on the provided search query.
  ///
  /// [searchQuery] is an optional map of query parameters for filtering the chat messages.
  /// Returns a list of [ChatModel] instances.
  Future<List<ChatModel>> get([Map<String, dynamic>? searchQuery]) async {
    try {
      final dio = AppDependencyInjector.getIt.get<DioClient>().dio;

      final response = await dio.get(
        '${Config.triagePlatformApiUrl}/chat',
        queryParameters:
            searchQuery != null && searchQuery.isNotEmpty ? searchQuery : null,
      );

      logger.i('Login response: ${response.data}');

      final List<ChatModel> chats = (response.data as List)
          .map((item) => ChatModel.fromJson(item))
          .toList();

      return chats;
    } on DioException catch (e) {
      logger.e('Failed to login: ${e.message}');
      throw Exception('Failed to login: ${e.message}');
    }
  }

  /// Initiates a new chat for the specified user.
  ///
  /// [userId] is the ID of the user for whom the chat is being initiated.
  /// [caseId] is the ID of the case associated with the chat if any.
  Future<void> initiateChat() async {
    try {
      final dio = AppDependencyInjector.getIt.get<DioClient>().dio;

      final response = await dio.get(
        '${Config.triagePlatformApiUrl}/chat/initiate',
      );

      logger.i('Login response: ${response.data}');

      return;
    } on DioException catch (e) {
      logger.e('Failed to login: ${e.message}');
      throw Exception('Failed to login: ${e.message}');
    }
  }

  /// Deletes chat messages for the specified user.
  ///
  /// [userId] is the ID of the user whose chat messages are to be deleted.
  /// [caseId] is the ID of the case associated with the chat messages if any.
  Future<void> delete() async {
    try {
      final dio = AppDependencyInjector.getIt.get<DioClient>().dio;

      final response = await dio.delete(
        '${Config.triagePlatformApiUrl}/chat?clearChat=true',
      );

      logger.i('Login response: ${response.data}');

      return;
    } on DioException catch (e) {
      logger.e('Failed to login: ${e.message}');
      throw Exception('Failed to login: ${e.message}');
    }
  }

  /// Sends a new chat message.
  ///
  /// [message] is the content of the chat message.
  /// [userId] is the ID of the user sending the message.
  /// [caseId] is the ID of the case associated with the message if any.
  Future<void> sendMessage(String message) async {
    try {
      final dio = AppDependencyInjector.getIt.get<DioClient>().dio;

      final body = {
        'message': message,
        "sender": "USER",
      };

      final response = await dio.post(
        '${Config.triagePlatformApiUrl}/chat',
        data: body,
      );

      logger.i('Login response: ${response.data}');

      return;
    } on DioException catch (e) {
      logger.e('Failed to login: ${e.message}');
      throw Exception('Failed to login: ${e.message}');
    }
  }

  /// Updates feedback for a specific chat message.
  ///
  /// [chatId] is the ID of the chat message to be updated.
  /// [comment] is the feedback comment.
  /// [rating] is the feedback rating.
  Future<void> updateFeedback(int chatId, String comment, int rating) async {
    try {
      final dio = AppDependencyInjector.getIt.get<DioClient>().dio;

      final response = await dio.patch(
          '${Config.triagePlatformApiUrl}/chat/$chatId',
          data: {'comment': comment, 'rating': rating});

      logger.i('Login response: ${response.data}');

      return;
    } on DioException catch (e) {
      logger.e('Failed to login: ${e.message}');
      throw Exception('Failed to login: ${e.message}');
    }
  }
}
