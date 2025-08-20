import 'package:flutter/material.dart';
import 'package:life_calendar2/core/constants/constants.dart';

class EventTextField extends StatefulWidget {
  const EventTextField({
    super.key,
    this.initialText,
    required this.onChanged,
    required this.onEditingComplete,
  });

  final String? initialText;
  final Function(String text) onChanged;
  final Function(String text) onEditingComplete;

  @override
  State<EventTextField> createState() => _EventTextFieldState();
}

class _EventTextFieldState extends State<EventTextField> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();

    _textController = TextEditingController(text: widget.initialText);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      maxLength: maxTitleLength,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
      ),
      onChanged: widget.onChanged,
      onEditingComplete: () => widget.onEditingComplete(_textController.text),
    );
  }
}
