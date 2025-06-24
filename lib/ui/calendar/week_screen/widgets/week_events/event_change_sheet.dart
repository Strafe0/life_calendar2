import 'package:flutter/material.dart';
import 'package:life_calendar2/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_events/event_text_field.dart';
import 'package:life_calendar2/ui/core/widgets/date_text_field.dart';

class EventChangeSheet extends StatefulWidget {
  const EventChangeSheet({
    super.key,
    required this.firstDate,
    required this.lastDate,
    required this.onSubmit,
  });

  final DateTime firstDate;
  final DateTime lastDate;
  final void Function(DateTime, String) onSubmit;

  @override
  State<EventChangeSheet> createState() => _EventChangeSheetState();
}

class _EventChangeSheetState extends State<EventChangeSheet> {
  DateTime? _dateTime;
  String? _title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateTextField(
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
          onDateSaved: (value) => _dateTime = value,
          onDateSubmitted: (value) => _dateTime = value,
        ),
        const SizedBox(height: 16),
        EventTextField(
          onEditingComplete: (title) {
            _title = title;
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: () {
            if (_dateTime != null && _title != null) {
              widget.onSubmit(_dateTime!, _title!);
            }
          },
          child: Text(context.l10n.ready),
        ),
      ],
    );
  }
}
