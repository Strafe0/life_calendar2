import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_calendar2/core/constants/constants.dart';
import 'package:life_calendar2/core/extensions/date_time/date_time_extension.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/core/utils/local_date_format_utils.dart';
import 'package:life_calendar2/ui/core/input_formatters/date_input_formatter.dart';

class DateTextField extends StatefulWidget {
  const DateTextField({
    super.key,
    required this.firstDate,
    required this.lastDate,
    this.initialDate,
    this.onChanged,
    this.fieldLabelText,
    this.errorFormatText,
  });

  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? initialDate;
  final void Function(String)? onChanged;
  final String? fieldLabelText;
  final String? errorFormatText;

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  final _dateController = TextEditingController();

  // Данные для локализации
  late String _separator;
  late List<int> _segmentLengths;
  late DateFormat _dateFormat; // Храним форматтер для парсинга и валидации

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _setupLocaleParameters();

    if (_dateController.text.isEmpty && widget.initialDate != null) {
      _dateController.text = _dateFormat.format(widget.initialDate!);
    }
  }

  void _setupLocaleParameters() {
    _dateFormat = getLocalDateFormat(Localizations.localeOf(context));
    final pattern = _dateFormat.pattern ?? 'dd.MM.yyyy';

    _separator = getLocalDateSeparatorByPattern(pattern);

    // Определяем порядок полей и длины сегментов
    // Это эвристика: смотрим, где находится 'y' (год)
    final int yIndex = pattern.indexOf('y');
    final int dIndex = pattern.indexOf('d');

    // Если год идет первым (yyyy-MM-dd), как в ISO/Японии
    if (yIndex < dIndex) {
      _segmentLengths = [4, 2, 2];
    } else {
      // Иначе (dd.MM.yyyy или MM/dd/yyyy)
      _segmentLengths = [2, 2, 4];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _dateController,
            keyboardType: TextInputType.datetime,
            inputFormatters: [
              UniversalDateInputFormatter(
                separator: _separator,
                segmentLengths: _segmentLengths,
              ),
            ],
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              hintText: getLocalizedHint(
                _dateFormat.pattern ?? dateFormatHintText,
                context.l10n,
              ),
              suffixIcon: IconButton(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    firstDate: widget.firstDate,
                    lastDate: widget.lastDate,
                  );

                  if (pickedDate != null &&
                      widget.onChanged != null &&
                      context.mounted) {
                    final pickedDateText = pickedDate.toLocalString(context);
                    widget.onChanged!(pickedDateText);
                    _dateController.text = pickedDateText;
                  }
                },
                icon: Icon(
                  Icons.calendar_month,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return null;
              }

              try {
                final parsedDate = _dateFormat.parse(value);

                if (parsedDate.isBefore(widget.firstDate) ||
                    parsedDate.isAfter(widget.lastDate)) {
                  return context.l10n.dateInvalid(
                    _dateFormat.format(widget.firstDate),
                    _dateFormat.format(widget.lastDate),
                  );
                }
                return null;
              } catch (e) {
                return widget.errorFormatText ?? context.l10n.dateFormatError;
              }
            },
          ),
        ),
      ],
    );
  }
}
