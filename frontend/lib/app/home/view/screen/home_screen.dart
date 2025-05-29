import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/app/home/bloc/home_bloc.dart';
import 'package:frontend/app/home/view/widget/feedback_dialog.dart';
import 'package:frontend/design/theme/colors.dart';
import 'package:go_router/go_router.dart';

// The home screen of the application.
class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controller for the message text field
  final TextEditingController _messageController = TextEditingController();
  // Scroll controller for the chat messages
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Initialize the home screen by sending an event to the BLoC
    context.read<HomeBloc>().add(
          HomePageInitiateEvent(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      // Rebuild the widget when the state changes
      listenWhen: (previous, current) => current is HomeActionState,
      // Only rebuild the widget when the state is not a HomeActionState
      buildWhen: (previous, current) => current is! HomeActionState,
      // Build the widget based on the current state
      builder: (BuildContext context, HomeState state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorsData.appBarColor,
            actions: [
              IconButton(
                icon: const Icon(Icons.info),
                color: Colors.white,
                onPressed: () {
                  // Navigate back to the previous screen
                  context.read<HomeBloc>().add(InfoButtonClickedEvent());
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.white,
                onPressed: () {
                  // Send an event to the BLoC to delete the chat messages
                  context.read<HomeBloc>().add(DeleteChatButtonClickedEvent());
                },
              ),
            ],
            title: Text(
              'Triage AI',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: (state is HomeLoadedState ||
                        state is HomeSendingMessageState)
                    ? ListView.builder(
                        controller: _scrollController,
                        reverse: true,
                        itemCount: state is HomeLoadedState
                            ? state.chats.length
                            : (state as HomeSendingMessageState).chats.length,
                        itemBuilder: (context, index) {
                          final chats = state is HomeLoadedState
                              ? state.chats
                              : (state as HomeSendingMessageState).chats;
                          final chat = chats[chats.length - 1 - index];
                          return Align(
                            alignment: chat.sender == 'BOT'
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: GestureDetector(
                              onLongPress: () {
                                // Send an event to the BLoC when a chat message is long pressed
                                context
                                    .read<HomeBloc>()
                                    .add(LongPressClickedEvent(
                                      chat: chat,
                                    ));
                              },
                              child: Column(
                                crossAxisAlignment: chat.sender == 'BOT'
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: 4.sp,
                                      horizontal: 8.sp,
                                    ),
                                    padding: EdgeInsets.all(12.sp),
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.7,
                                    ),
                                    decoration: BoxDecoration(
                                      color: chat.sender == 'BOT'
                                          ? Colors.grey[300]
                                          : Colors.blue[100],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12.sp),
                                        topRight: Radius.circular(12.sp),
                                        bottomLeft: chat.sender == 'BOT'
                                            ? Radius.circular(0)
                                            : Radius.circular(12.sp),
                                        bottomRight: chat.sender == 'BOT'
                                            ? Radius.circular(12.sp)
                                            : Radius.circular(0),
                                      ),
                                    ),
                                    child: Text(
                                      chat.message,
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                  ),
                                  if (chat.comment != null ||
                                      chat.rating != null)
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 4.sp, left: 8.sp, right: 8.sp),
                                      padding: EdgeInsets.all(8.sp),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(8.sp),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (chat.rating != null)
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children:
                                                  List.generate(5, (index) {
                                                return Icon(
                                                  index < chat.rating!
                                                      ? Icons.star
                                                      : Icons.star_border,
                                                  color: Colors.amber,
                                                  size: 16.sp,
                                                );
                                              }),
                                            ),
                                          if (chat.comment != null)
                                            Text(
                                              chat.comment!,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
              Padding(
                padding: EdgeInsets.all(8.sp),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.sp),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.sp,
                            vertical: 10.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.sp),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        if (_messageController.text.isNotEmpty) {
                          // Send an event to the BLoC to send a message
                          context.read<HomeBloc>().add(
                                SendMessageEvent(
                                  message: _messageController.text.trim(),
                                ),
                              );
                          _messageController.clear();
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.sp),
            ],
          ),
        );
      },
      // Listen for state changes and navigate to the login page if needed
      listener: (BuildContext context, HomeState state) {
        // Navigate to the login page if the user is not authenticated
        if (state is NavigateToLoginPageActionState) {
          GoRouter.of(context).goNamed('Login');
        }
        // Scroll to the top of the chat messages when the chat is loaded or a message is sent
        if (state is HomeLoadedState || state is HomeSendingMessageState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollController.jumpTo(0);
          });
        }
        // Show a feedback dialog when the user long presses a chat message
        else if (state is HomeInitialState) {
          context.read<HomeBloc>().add(
                HomePageInitiateEvent(),
              );
        }
        // Show a feedback dialog when the user long presses a chat message
        else if (state is ShowFeedbackDialogActionState) {
          showDialog(
            context: context,
            builder: (context) => FeedbackDialog(chat: state.chat),
          );
        }

        // Navigate to the info screen when the user clicks the info button
        else if (state is NavigateToInfoScreenActionState) {
          GoRouter.of(context).pushNamed('Info');
        }
      },
    );
  }
}
