import 'package:flutter/material.dart';
import 'package:life_calendar/core/extensions/string/string_extension.dart';
import 'package:life_calendar/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar/core/logger/logger.dart';
import 'package:life_calendar/core/utils/local_date_format_utils.dart';
import 'package:life_calendar/ui/calendar/week_screen/widgets/week_events/event_text_field.dart';
import 'package:life_calendar/ui/core/widgets/date_text_field.dart';

class EventChangeSheet extends StatefulWidget {
  const EventChangeSheet({
    super.key,
    required this.firstDate,
    required this.lastDate,
    this.initialDate,
    this.initialTitle,
    required this.onSubmit,
  });

  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? initialDate;
  final String? initialTitle;
  final void Function(DateTime, String) onSubmit;

  @override
  State<EventChangeSheet> createState() => _EventChangeSheetState();
}

class _EventChangeSheetState extends State<EventChangeSheet> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _dateTime;
  String? _title;

  @override
  void initState() {
    super.initState();
    _dateTime = widget.initialDate;
    _title = widget.initialTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          EventTextField(
            initialText: _title,
            onChanged: (title) => _title = title,
            onEditingComplete: (_) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
          const SizedBox(height: 16),
          DateTextField(
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            initialDate: _dateTime,
            fieldLabelText: context.l10n.enterDate,
            errorFormatText: context.l10n.dateFormatError,
            onChanged: (value) {
              final locale = Localizations.localeOf(context);

              _dateTime = value.toDateTime(
                locale: locale.toString(),
                pattern: getLocalDateFormat(locale).pattern,
              );
            },
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {
              logger.d('onReadyPressed: $_dateTime, $_title');

              final isValid = _formKey.currentState?.validate() ?? false;

              if (isValid && _dateTime != null && _title != null) {
                logger.d('invoke onSubmit');
                widget.onSubmit(_dateTime!, _title!);
              }
            },
            child: Text(context.l10n.ready),
          ),
        ],
      ),
    );
  }
}
