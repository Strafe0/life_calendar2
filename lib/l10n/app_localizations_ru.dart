// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Календарь жизни';

  @override
  String get loading => 'Загрузка';

  @override
  String get errorHappened => 'Произошла ошибка';

  @override
  String get tryAgain => 'Попробовать снова';

  @override
  String get week => 'Неделя';

  @override
  String get goals => 'Цели';

  @override
  String get noGoals => 'Нет целей';

  @override
  String get events => 'События';

  @override
  String get noEvents => 'Нет событий';

  @override
  String get photos => 'Фото';

  @override
  String get noPhotos => 'Нет фото';

  @override
  String get resume => 'Итог';

  @override
  String get noResume => 'Нет итога';

  @override
  String get rateWeek => 'Дайте оценку неделе';

  @override
  String get edit => 'Изменить';

  @override
  String get delete => 'Удалить';

  @override
  String get skip => 'Пропустить';
}
