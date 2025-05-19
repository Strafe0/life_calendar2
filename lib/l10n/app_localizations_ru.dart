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

  @override
  String get onboardingTitleWelcome => 'Календарь жизни в неделях';

  @override
  String get onboardingContentWelcome => 'Этот календарь дает наглядное представление о количестве прожитых и оставшихся неделей нашей жизни.';

  @override
  String get onboardingTitleGrid => 'Календарь жизни в неделях';

  @override
  String get onboardingContentGrid => 'Каждая строка календаря соответствует одному году (52 или 53 недели). Каждый год начинается с недели, которая содержит ваш день рождения.';

  @override
  String get onboardingTitleZoom => 'Увеличивайте календарь и выбирайте неделю';

  @override
  String get onboardingContentZoom => 'Вы можете приблизить календарь. Нажав на квадрат, вы перейдете на экран выбранной недели.';

  @override
  String get onboardingTitleJumpToCurrentWeek => 'Переходите к текущей неделе одним нажатием';

  @override
  String get onboardingContentJumpToCurrentWeek => 'Чтобы сразу перейти к текущей неделе, нажмите на кнопку снизу справа.';

  @override
  String get enterBirthday => 'Введите дату рождения';

  @override
  String get enterLifespan => 'Введите продолжительность жизни';

  @override
  String get ready => 'Готово';

  @override
  String get lifespanInterval => 'Введите целое число от 60 до 100 лет';
}
