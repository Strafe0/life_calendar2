import 'package:flutter/material.dart';
import 'package:life_calendar2/core/logger.dart';
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
          fieldLabelText: context.l10n.enterDate,
          errorFormatText: context.l10n.dateFormatError,
          onDateSaved: (value) {
            logger.d('onDateSaved: $value');
            _dateTime = value;
          },
          onDateSubmitted: (value) {
            logger.d('onDateSubmitted: $value');
            _dateTime = value;
          },
        ),
        const SizedBox(height: 16),
        EventTextField(
          onChanged: (title) => _title = title,
          onEditingComplete: (_) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: () {
            logger.d('onReadyPressed: $_dateTime, $_title');
            if (_dateTime != null && _title != null) {
              logger.d('invoke onSubmit');
              widget.onSubmit(_dateTime!, _title!);
            }
          },
          child: Text(context.l10n.ready),
        ),
      ],
    );
  }
}
