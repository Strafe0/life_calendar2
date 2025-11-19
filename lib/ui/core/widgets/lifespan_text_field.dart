import 'package:flutter/material.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/domain/models/user/user.dart';

class LifeSpanTextField extends StatelessWidget {
  const LifeSpanTextField({super.key, this.controller, this.validator});

  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: context.l10n.enterLifespan),
      keyboardType: TextInputType.number,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      validator:
          validator ??
          (value) {
            final lifeSpan = int.tryParse(value ?? '');
            if (lifeSpan == null || !User.isLifeSpanValid(lifeSpan)) {
              return context.l10n.lifespanInterval(
                User.minLifeSpan,
                User.maxLifeSpan,
              );
            }

            return null;
          },
    );
  }
}
