import 'package:flutter/material.dart';
import 'package:life_calendar2/core/constants/constants.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';

class GoalChangeSheet extends StatefulWidget {
  const GoalChangeSheet({super.key, required this.onSubmit, this.initialText});

  final String? initialText;
  final void Function(String) onSubmit;

  @override
  State<GoalChangeSheet> createState() => _GoalChangeSheetState();
}

class _GoalChangeSheetState extends State<GoalChangeSheet> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();

    _textController = TextEditingController(text: widget.initialText);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _textController,
          maxLength: maxTitleLength,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(border: UnderlineInputBorder()),
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: () {
            final title = _textController.text;
            if (title.isNotEmpty) {
              widget.onSubmit(title);
            }
          },
          child: Text(context.l10n.ready),
        ),
      ],
    );
  }
}
