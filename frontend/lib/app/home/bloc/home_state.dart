part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<ChatModel> chats;
  HomeLoadedState(this.chats);
}

class HomeSendingMessageState extends HomeState {
  final List<dynamic> chats;
  HomeSendingMessageState(this.chats);
}

class HomeErrorState extends HomeState {
  final String error;
  HomeErrorState(this.error);
}

abstract class HomeActionState extends HomeState {}

class NavigateToLoginPageActionState extends HomeActionState {}

class HomeInitialState extends HomeActionState {}

class ShowFeedbackDialogActionState extends HomeActionState {
  final ChatModel chat;

  ShowFeedbackDialogActionState({required this.chat});
}

class NavigateToInfoScreenActionState extends HomeActionState {}
