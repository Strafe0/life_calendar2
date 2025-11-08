import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/extensions/string/string_extension.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/ui/core/widgets/date_text_field.dart';
import 'package:life_calendar2/ui/user/bloc/user_bloc.dart';
import 'package:life_calendar2/ui/user/bloc/user_state.dart';

class SearchSheet extends StatefulWidget {
  const SearchSheet({super.key, required this.onSubmit});

  final void Function(int weekId) onSubmit;

  @override
  State<SearchSheet> createState() => _SearchSheetState();
}

class _SearchSheetState extends State<SearchSheet> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _dateTime;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return switch (state) {
          UserSuccess(:final user) => Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 32),
                DateTextField(
                  firstDate: user.birthdate,
                  lastDate: user.lastDate,
                  fieldLabelText: context.l10n.enterDate,
                  errorFormatText: context.l10n.dateFormatError,
                  onChanged: (value) => _dateTime = value.toDateTime(),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {
                    final isValid = _formKey.currentState?.validate() ?? false;

                    if (isValid && _dateTime != null) {
                      widget.onSubmit(
                        _searchWeekId(
                          _dateTime!,
                          user.birthdate,
                          user.lifeSpan,
                        ),
                      );
                    }
                  },
                  child: Text(context.l10n.ready),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          UserFailure() => Center(child: Text(context.l10n.errorHappened)),
          _ => const Center(child: CircularProgressIndicator()),
        };
      },
    );
  }

  int _searchWeekId(DateTime date, DateTime birthdate, int lifeSpan) {
    if (date.isBefore(birthdate)) {
      logger.w('Searched date cannot be earlier than birthdate');
    } else if (date.isAfter(
      DateTime(birthdate.year + lifeSpan, birthdate.month, birthdate.day),
    )) {
      logger.w('Searched date cannot be later than last day');
    }

    final diff = date.difference(birthdate);
    logger.d('Found week id: ${diff.inDays / 7} (${diff.inDays ~/ 7 + 1})');

    return diff.inDays ~/ 7 + 1;
  }
}
