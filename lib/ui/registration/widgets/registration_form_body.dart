import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/constants/constants.dart';
import 'package:life_calendar2/core/extensions/string/string_extension.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/domain/models/user/user.dart';
import 'package:life_calendar2/ui/core/widgets/date_text_field.dart';
import 'package:life_calendar2/ui/registration/bloc/registration_cubit.dart';

class RegistrationFormBody extends StatefulWidget {
  const RegistrationFormBody({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  State<RegistrationFormBody> createState() => _RegistrationFormBodyState();
}

class _RegistrationFormBodyState extends State<RegistrationFormBody> {
  bool _isLoading = false;
  final _lifeSpanTextController = TextEditingController();
  DateTime? _birthdate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateTextField(
          firstDate: firstAvailableDate,
          lastDate: DateTime.now(),
          initialDate: _birthdate,
          fieldLabelText: context.l10n.enterBirthdate,
          errorFormatText: context.l10n.dateFormatError,
          onChanged: (value) => _birthdate = value.toDateTime(),
          onDateSaved: (value) {
            _birthdate = value;
            logger.d('birthdate form saved: $_birthdate');
          },
          onDateSubmitted: (value) {
            setState(() => _birthdate = value);
            logger.d('birthdate form submitted: $_birthdate');
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _lifeSpanTextController,
          decoration: InputDecoration(labelText: context.l10n.enterLifespan),
          keyboardType: TextInputType.number,
          onTapOutside:
              (event) => FocusManager.instance.primaryFocus?.unfocus(),
          validator: (value) {
            final lifeSpan = int.tryParse(value ?? '');
            if (lifeSpan == null || !_lifeSpanIsValid(lifeSpan)) {
              return context.l10n.lifespanInterval(
                User.minLifeSpan,
                User.maxLifeSpan,
              );
            }

            return null;
          },
        ),
        const Spacer(),
        OutlinedButton(
          onPressed: () async {
            if (_isLoading) return;
            setState(() => _isLoading = true);

            final form = widget.formKey.currentState;
            if (form != null) {
              form.save();
              final enteredDataIsValid = form.validate();
              if (enteredDataIsValid) {
                final lifeSpan = int.tryParse(_lifeSpanTextController.text);
                if (_birthdate != null && lifeSpan != null) {
                  await context.read<RegistrationCubit>().register(
                    birthday: _birthdate!,
                    lifeSpan: lifeSpan,
                  );
                }
              }
            }

            setState(() => _isLoading = false);
          },
          child: Text(context.l10n.ready),
        ),
      ],
    );
  }

  bool _lifeSpanIsValid(int lifeSpan) =>
      User.minLifeSpan <= lifeSpan && lifeSpan <= User.maxLifeSpan;
}
