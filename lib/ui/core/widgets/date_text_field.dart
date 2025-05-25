import 'package:flutter/material.dart';
import 'package:life_calendar2/core/extensions/date_time/date_time_extension.dart';
import 'package:life_calendar2/l10n/app_localizations_extension.dart';

class DateTextField extends StatelessWidget {
  const DateTextField({
    super.key,
    required this.firstDate,
    required this.lastDate,
    this.initialDate,
    this.onDateSaved,
    this.onDateSubmitted,
  });

  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? initialDate;
  final ValueChanged<DateTime>? onDateSaved;
  final ValueChanged<DateTime>? onDateSubmitted;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InputDatePickerFormField(
            firstDate: firstDate,
            lastDate: lastDate,
            initialDate: initialDate,
            fieldLabelText: context.l10n.enterBirthdate,
            errorFormatText: context.l10n.dateFormatError,
            errorInvalidText: context.l10n.dateInvalid(
              firstDate.toLocalString(context),
              lastDate.toLocalString(context),
            ),
            onDateSaved: onDateSaved,
            onDateSubmitted: onDateSubmitted,
          ),
        ),
        IconButton(
          onPressed: () async {
            final pickedDate = await showDatePicker(
              context: context,
              firstDate: firstDate,
              lastDate: lastDate,
            );

            if (pickedDate != null && onDateSubmitted != null) {
              onDateSubmitted!(pickedDate);
            }
          },
          icon: Icon(
            Icons.calendar_month,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
