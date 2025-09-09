import 'package:flutter/material.dart';
import 'package:life_calendar2/core/constants/constants.dart';
import 'package:life_calendar2/core/extensions/date_time/date_time_extension.dart';
import 'package:life_calendar2/core/extensions/string/string_extension.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/core/input_formatters/date_input_formatter.dart';

class DateTextField extends StatefulWidget {
  const DateTextField({
    super.key,
    required this.firstDate,
    required this.lastDate,
    this.initialDate,
    this.onDateSaved,
    this.onDateSubmitted,
    this.onChanged,
    this.fieldLabelText,
    this.errorFormatText,
  });

  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? initialDate;
  final ValueChanged<DateTime>? onDateSaved;
  final ValueChanged<DateTime>? onDateSubmitted;
  final void Function(String)? onChanged;
  final String? fieldLabelText;
  final String? errorFormatText;

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  final _dateController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _dateController.text = widget.initialDate?.toLocalString(context) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _dateController,
            keyboardType: TextInputType.datetime,
            inputFormatters: [const DateInputFormatter(separator: '.')],
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              hintText: dateFormatHintText,
              suffixIcon: IconButton(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    firstDate: widget.firstDate,
                    lastDate: widget.lastDate,
                  );

                  if (pickedDate != null && widget.onDateSubmitted != null) {
                    widget.onDateSubmitted!(pickedDate);
                  }
                },
                icon: Icon(
                  Icons.calendar_month,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            validator: (value) {
              final parsedDate = value?.toDateTime();
              if (parsedDate == null) {
                return context.l10n.dateFormatError;
              } else if (parsedDate.isBefore(widget.firstDate) ||
                  parsedDate.isAfter(widget.lastDate)) {
                return context.l10n.dateInvalid(
                  widget.firstDate.toLocalString(context),
                  widget.lastDate.toLocalString(context),
                );
              }

              return null;
            },
          ),
        ),
      ],
    );
  }
}
