import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/app/home/bloc/home_bloc.dart';
import 'package:frontend/app/home/data/model/chat_model.dart';

/// A dialog widget for providing feedback on a chat message.
class FeedbackDialog extends StatefulWidget {
  final ChatModel chat;

  const FeedbackDialog({Key? key, required this.chat}) : super(key: key);

  @override
  _FeedbackDialogState createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  // Controller for the comment text field
  late TextEditingController _commentController;
  // Rating value for the chat message
  int _rating = 0;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the chat's comment
    _commentController = TextEditingController(text: widget.chat.comment);
    // Initialize the rating with the chat's rating
    _rating = widget.chat.rating ?? 0;
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is removed
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Provide Feedback'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Text field for entering a comment
          TextField(
            controller: _commentController,
            decoration: InputDecoration(labelText: 'Comment'),
            maxLines: 3,
          ),
          SizedBox(height: 16),
          // Row of star icons for selecting the rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
                onPressed: () {
                  setState(() {
                    _rating = index + 1;
                  });
                },
              );
            }),
          ),
        ],
      ),
      actions: [
        // Cancel button to close the dialog without submitting feedback
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        // Submit button to submit the feedback
        ElevatedButton(
          onPressed: () {
            context.read<HomeBloc>().add(UpdateFeedbackEvent(
                  chatId: widget.chat.id,
                  comment: _commentController.text,
                  rating: _rating,
                ));
            Navigator.of(context).pop();
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}
