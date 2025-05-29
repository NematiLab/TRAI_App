part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class LogoutButtonClickedEvent extends HomeEvent {}

class HomePageInitiateEvent extends HomeEvent {}

class SendMessageEvent extends HomeEvent {
  final String message;

  SendMessageEvent({
    required this.message,
  });
}

class DeleteChatButtonClickedEvent extends HomeEvent {}

class LongPressClickedEvent extends HomeEvent {
  final ChatModel chat;

  LongPressClickedEvent({
    required this.chat,
  });
}

class UpdateFeedbackEvent extends HomeEvent {
  final int chatId;
  final String comment;
  final int rating;

  UpdateFeedbackEvent({
    required this.chatId,
    required this.comment,
    required this.rating,
  });
}

class InfoButtonClickedEvent extends HomeEvent {}
