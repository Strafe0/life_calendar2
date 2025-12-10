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
  String get goal => 'Цель';

  @override
  String get noGoals => 'Нет целей';

  @override
  String get goalCreation => 'Создание цели';

  @override
  String get goalEdit => 'Изменение цели';

  @override
  String get events => 'События';

  @override
  String get event => 'Событие';

  @override
  String get noEvents => 'Нет событий';

  @override
  String get eventCreation => 'Создание события';

  @override
  String get eventEdit => 'Изменение события';

  @override
  String get photos => 'Фото';

  @override
  String get photo => 'Фото';

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
  String get onboardingContentWelcome =>
      'Этот календарь дает наглядное представление о количестве прожитых и оставшихся неделей нашей жизни.';

  @override
  String get onboardingTitleGrid => 'Календарь жизни в неделях';

  @override
  String get onboardingContentGrid =>
      'Каждая строка календаря соответствует одному году (52 или 53 недели). Каждый год начинается с недели, которая содержит ваш день рождения.';

  @override
  String get onboardingTitleZoom => 'Увеличивайте календарь и выбирайте неделю';

  @override
  String get onboardingContentZoom =>
      'Вы можете приблизить календарь. Нажав на квадрат, вы перейдете на экран выбранной недели.';

  @override
  String get onboardingTitleJumpToCurrentWeek =>
      'Переходите к текущей неделе одним нажатием';

  @override
  String get onboardingContentJumpToCurrentWeek =>
      'Чтобы сразу перейти к текущей неделе, нажмите на кнопку снизу справа.';

  @override
  String get enterBirthdate => 'Введите дату рождения';

  @override
  String get dateFormatError => 'Неверный формат даты';

  @override
  String dateInvalid(String start, String end) {
    return 'Введите дату $start - $end';
  }

  @override
  String get enterDate => 'Введите дату';

  @override
  String get enterLifespan => 'Введите продолжительность жизни';

  @override
  String get lifespanFormatError => 'Неверный формат';

  @override
  String get ready => 'Готово';

  @override
  String lifespanInterval(int start, int end) {
    return 'Введите целое число от $start до $end лет';
  }

  @override
  String get registrationUserError => 'Не удалось создать пользователя';

  @override
  String get registrationCalendarError => 'Не удалось создать календарь';

  @override
  String get errorEmptyField => 'Поле не может быть пустым';

  @override
  String get error => 'Ошибка';

  @override
  String get errorAdLoading => 'Не получилось загрузить рекламу';

  @override
  String get gotIt => 'Понятно';

  @override
  String get errorPhotoAttach => 'Не получилось прикрепить фото';

  @override
  String get birthdate => 'Дата рождения';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get calendarExport => 'Экспорт календаря';

  @override
  String get exportDialogTitle => 'Экспорт данных приложения';

  @override
  String get archiveCreationInProcess => 'Происходит создание архива';

  @override
  String get archiveCreationSuccess => 'Архив успешно создан';

  @override
  String get errorArchiveCreation =>
      'Произошла ошибка при создании архива. Попробуйте снова.';

  @override
  String get calendarImport => 'Импорт календаря';

  @override
  String get importDialogTitle => 'Импорт данных приложения';

  @override
  String get importDrawerDialogMessage =>
      'При импорте календаря все ваши текущие данные будут удалены и заменены новыми!\n\nУбедитесь, что старые данные вам не нужны, или сделайте экспорт.\n\nПосле импорта вам нужно будет перезайти в приложение.';

  @override
  String get errorImport => 'Произошла ошибка во время импорта';

  @override
  String get errorPrivacyPolicy =>
      'Не получилось перейти к политике конфиденциальности';

  @override
  String get cancel => 'Отмена';

  @override
  String get continueButton => 'Продолжить';

  @override
  String get feedback => 'Обратная связь';

  @override
  String get contactDeveloper => 'Связь с разработчиком';

  @override
  String get leaveReviewMessage =>
      'Если вам понравилось приложение,\n напишите положительный отзыв!';

  @override
  String get writeFeedbackToMail =>
      'Для предложений и сообщениях об ошибках\n пишите на почту.';

  @override
  String get errorWriteFeedback => 'Упс... Возникла неизвестная проблема';

  @override
  String get writeButton => 'Написать';

  @override
  String get pullToSearch => 'Потяните для поиска';

  @override
  String get releaseToSearch => 'Отпустите для поиска';

  @override
  String get search => 'Поиск';

  @override
  String get pullToGoToCurrentWeek => 'Перейти к текущей неделе';

  @override
  String get donate => 'Поблагодарить';

  @override
  String get donateDialogTitle => 'Ваша поддержка важна';

  @override
  String get donateDialogMessage =>
      'Проект создаётся в свободное время с любовью и вниманием к деталям. Если приложение оказалось полезным, буду благодарен за поддержку — она помогает мне двигаться дальше.';

  @override
  String get donateDialogButtonPositive => 'Поддержать проект';

  @override
  String get donateDialogButtonNegative => 'Пока не готов';

  @override
  String get tryAgainLater => 'Попробовать позже';

  @override
  String get buttonYes => 'Да';

  @override
  String get buttonNo => 'Нет';

  @override
  String get changeLifespan => 'Изменить продолжительности жизни';

  @override
  String get confirmChanges => 'Подтвердите изменения';

  @override
  String get lifespanChangeDialogMessage =>
      'При уменьшении срока жизни будут удалены данные будущих недель. Продолжить?';

  @override
  String get exitAppDialogTitle => 'Выход из приложения';

  @override
  String get exitAppDialogMessage =>
      'Вы действительно хотите покинуть приложение?';

  @override
  String get daySymbol => 'Д';

  @override
  String get monthSymbol => 'М';

  @override
  String get yearSymbol => 'Г';

  @override
  String get assessmentGood => 'Хорошо 🤩';

  @override
  String get assessmentBad => 'Плохо 🫠';

  @override
  String get assessmentPoor => 'Нейтрально 😐';

  @override
  String widgetWeeksStats(int current, int total) {
    return '$current/$total недель';
  }

  @override
  String widgetLifeStats(int percent) {
    return '$percent% жизни';
  }

  @override
  String widgetGoalsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count целей',
      many: '$count целей',
      few: '$count цели',
      one: '$count цель',
      zero: 'Нет целей',
    );
    return '$_temp0';
  }

  @override
  String widgetEventsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count событий',
      many: '$count событий',
      few: '$count события',
      one: '$count событие',
      zero: 'Нет событий',
    );
    return '$_temp0';
  }

  @override
  String get notificationSwitchTitle => 'Воскресное напоминание';

  @override
  String get notificationWeeklyReviewTitle => 'Время для себя';

  @override
  String get notificationWeeklyReviewBody =>
      'Воскресный вечер — лучшее время, чтобы вспомнить всё хорошее. Загляни в календарь.';
}
