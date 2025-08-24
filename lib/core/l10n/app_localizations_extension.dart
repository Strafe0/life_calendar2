import 'package:flutter/widgets.dart';
import 'package:life_calendar2/core/l10n/app_localizations.dart';

extension AppLocalizationsExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
