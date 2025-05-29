import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:frontend/app/home/data/model/chat_model.dart';
import 'package:frontend/app/home/data/services/chat_service.dart';
import 'package:frontend/core/dependency_injection/dependency_injection.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Logger logger = Logger();

  ChatService chatService = AppDependencyInjector.getIt.get();

  HomeBloc() : super(HomeInitial()) {
    on<HomePageInitiateEvent>(_homePageInitiateEvent);
    on<SendMessageEvent>(_sendMessageEvent);
    on<DeleteChatButtonClickedEvent>(_deleteChatButtonClickedEvent);
    on<LongPressClickedEvent>(_longPressClickedEvent);
    on<UpdateFeedbackEvent>(_updateFeedbackEvent);
    on<InfoButtonClickedEvent>(_infoButtonClickedEvent);
  }

  // Function to handle the info button clicked event
  FutureOr<void> _infoButtonClickedEvent(
      InfoButtonClickedEvent event, Emitter<HomeState> emit) {
    try {
      // Emit the show info dialog action state
      emit(NavigateToInfoScreenActionState());
    } catch (e) {
      logger.e(e.toString());
      // Emit the home error state with the error message
      emit(HomeErrorState('Failed to show info dialog: $e'));
    }
  }

  // Function to handle the home page initiate event
  FutureOr<void> _homePageInitiateEvent(
      HomePageInitiateEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      // Fetch the chat messages for the specified user
      final query = {
        'sortBy': 'createdAt',
        'sortOrder': 'asc',
      };

      // Initiate a new chat for the specified user
      await chatService.initiateChat();

      final chats = await chatService.get(query);
      // Emit the home loaded state with the fetched chat messages
      emit(HomeLoadedState(chats));
    } catch (e) {
      // Emit the home error state with the error message
      emit(HomeErrorState('Failed to load chats: $e'));
    }
  }

  // Function to handle the send message event
  FutureOr<void> _sendMessageEvent(
      SendMessageEvent event, Emitter<HomeState> emit) async {
    try {
      // Get the current state
      if (state is HomeLoadedState) {
        // Get the previous chats
        final prevChats = (state as HomeLoadedState).chats;
        // Create a new chat message
        final newMessage = ChatModel(
          message: event.message,
          id: 0,
          sender: 'USER',
        );
        // Create a loading message
        final loadMessage = ChatModel(
          message: ".......",
          id: 0,
          sender: 'BOT',
        );
        // Add the new message to the previous chats
        final updatedChats = [...prevChats, newMessage, loadMessage];
        // Emit the home sending message state with the updated chats
        emit(HomeSendingMessageState(updatedChats));
      }

      final query = {
        'sortBy': 'createdAt',
        'sortOrder': 'asc',
      };

      // Send the message
      await chatService.sendMessage(event.message);

      final chats = await chatService.get(query);
      // Emit the home loaded state with the fetched chat messages
      emit(HomeLoadedState(chats));
    } catch (e) {
      // Emit the home error state with the error message
      emit(HomeErrorState('Failed to send message: $e'));
    }
  }

  // Function to handle the delete chat button clicked event
  FutureOr<void> _deleteChatButtonClickedEvent(
      DeleteChatButtonClickedEvent event, Emitter<HomeState> emit) async {
    try {
      // Emit the home loading state
      emit(HomeLoadingState());
      // Delete the chat messages for the specified user
      await chatService.delete();
      // Emit the home initial state
      emit(HomeInitialState());
    } catch (e) {
      // Emit the home error state with the error message
      emit(HomeErrorState('Failed to delete chat: $e'));
    }
  }

  // Function to handle the long press clicked event
  FutureOr<void> _longPressClickedEvent(
      LongPressClickedEvent event, Emitter<HomeState> emit) {
    try {
      logger.i(event.chat.toJson());
      // Emit the show feedback dialog action state
      emit(ShowFeedbackDialogActionState(
        chat: event.chat,
      ));
    } catch (e) {
      logger.e(e.toString());
      // Emit the home error state with the error message
      emit(HomeErrorState('Failed to delete chat: $e'));
    }
  }

  // Function to handle the update feedback event
  FutureOr<void> _updateFeedbackEvent(
      UpdateFeedbackEvent event, Emitter<HomeState> emit) async {
    try {
      // Update the feedback for the specified chat message
      await chatService.updateFeedback(
        event.chatId,
        event.comment,
        event.rating,
      );
      // Fetch the updated chat messages
      final updatedChats = await chatService.get({
        'sortBy': 'createdAt',
        'sortOrder': 'asc',
      });
      // Emit the home loaded state with the updated chat messages
      emit(HomeLoadedState(updatedChats));
    } catch (e) {
      logger.e(e.toString());
      // Emit the home error state with the error message
      emit(HomeErrorState('Failed to update feedback: $e'));
    }
  }
}
