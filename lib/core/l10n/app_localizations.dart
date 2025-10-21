import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('ru')];

  /// Название приложения
  ///
  /// In ru, this message translates to:
  /// **'Календарь жизни'**
  String get appTitle;

  /// Текст загрузки
  ///
  /// In ru, this message translates to:
  /// **'Загрузка'**
  String get loading;

  /// Текст общей ошибки без конкретики
  ///
  /// In ru, this message translates to:
  /// **'Произошла ошибка'**
  String get errorHappened;

  /// Текст для кнопки
  ///
  /// In ru, this message translates to:
  /// **'Попробовать снова'**
  String get tryAgain;

  /// No description provided for @week.
  ///
  /// In ru, this message translates to:
  /// **'Неделя'**
  String get week;

  /// No description provided for @goals.
  ///
  /// In ru, this message translates to:
  /// **'Цели'**
  String get goals;

  /// No description provided for @goal.
  ///
  /// In ru, this message translates to:
  /// **'Цель'**
  String get goal;

  /// No description provided for @noGoals.
  ///
  /// In ru, this message translates to:
  /// **'Нет целей'**
  String get noGoals;

  /// No description provided for @goalCreation.
  ///
  /// In ru, this message translates to:
  /// **'Создание цели'**
  String get goalCreation;

  /// No description provided for @goalEdit.
  ///
  /// In ru, this message translates to:
  /// **'Изменение цели'**
  String get goalEdit;

  /// No description provided for @events.
  ///
  /// In ru, this message translates to:
  /// **'События'**
  String get events;

  /// No description provided for @event.
  ///
  /// In ru, this message translates to:
  /// **'Событие'**
  String get event;

  /// No description provided for @noEvents.
  ///
  /// In ru, this message translates to:
  /// **'Нет событий'**
  String get noEvents;

  /// No description provided for @eventCreation.
  ///
  /// In ru, this message translates to:
  /// **'Создание события'**
  String get eventCreation;

  /// No description provided for @eventEdit.
  ///
  /// In ru, this message translates to:
  /// **'Изменение события'**
  String get eventEdit;

  /// No description provided for @photos.
  ///
  /// In ru, this message translates to:
  /// **'Фото'**
  String get photos;

  /// No description provided for @photo.
  ///
  /// In ru, this message translates to:
  /// **'Фото'**
  String get photo;

  /// No description provided for @noPhotos.
  ///
  /// In ru, this message translates to:
  /// **'Нет фото'**
  String get noPhotos;

  /// No description provided for @resume.
  ///
  /// In ru, this message translates to:
  /// **'Итог'**
  String get resume;

  /// No description provided for @noResume.
  ///
  /// In ru, this message translates to:
  /// **'Нет итога'**
  String get noResume;

  /// No description provided for @rateWeek.
  ///
  /// In ru, this message translates to:
  /// **'Дайте оценку неделе'**
  String get rateWeek;

  /// No description provided for @edit.
  ///
  /// In ru, this message translates to:
  /// **'Изменить'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In ru, this message translates to:
  /// **'Удалить'**
  String get delete;

  /// No description provided for @skip.
  ///
  /// In ru, this message translates to:
  /// **'Пропустить'**
  String get skip;

  /// No description provided for @onboardingTitleWelcome.
  ///
  /// In ru, this message translates to:
  /// **'Календарь жизни в неделях'**
  String get onboardingTitleWelcome;

  /// No description provided for @onboardingContentWelcome.
  ///
  /// In ru, this message translates to:
  /// **'Этот календарь дает наглядное представление о количестве прожитых и оставшихся неделей нашей жизни.'**
  String get onboardingContentWelcome;

  /// No description provided for @onboardingTitleGrid.
  ///
  /// In ru, this message translates to:
  /// **'Календарь жизни в неделях'**
  String get onboardingTitleGrid;

  /// No description provided for @onboardingContentGrid.
  ///
  /// In ru, this message translates to:
  /// **'Каждая строка календаря соответствует одному году (52 или 53 недели). Каждый год начинается с недели, которая содержит ваш день рождения.'**
  String get onboardingContentGrid;

  /// Заголовок подсказки о приближении календаря
  ///
  /// In ru, this message translates to:
  /// **'Увеличивайте календарь и выбирайте неделю'**
  String get onboardingTitleZoom;

  /// Текст подсказки о приближении календаря
  ///
  /// In ru, this message translates to:
  /// **'Вы можете приблизить календарь. Нажав на квадрат, вы перейдете на экран выбранной недели.'**
  String get onboardingContentZoom;

  /// Заголовок подсказки о переходе к текущей неделе
  ///
  /// In ru, this message translates to:
  /// **'Переходите к текущей неделе одним нажатием'**
  String get onboardingTitleJumpToCurrentWeek;

  /// Текст подсказки о переходе к текущей неделе
  ///
  /// In ru, this message translates to:
  /// **'Чтобы сразу перейти к текущей неделе, нажмите на кнопку снизу справа.'**
  String get onboardingContentJumpToCurrentWeek;

  /// No description provided for @enterBirthdate.
  ///
  /// In ru, this message translates to:
  /// **'Введите дату рождения'**
  String get enterBirthdate;

  /// No description provided for @dateFormatError.
  ///
  /// In ru, this message translates to:
  /// **'Неверный формат даты'**
  String get dateFormatError;

  /// No description provided for @dateInvalid.
  ///
  /// In ru, this message translates to:
  /// **'Введите дату {start} - {end}'**
  String dateInvalid(String start, String end);

  /// No description provided for @enterDate.
  ///
  /// In ru, this message translates to:
  /// **'Введите дату'**
  String get enterDate;

  /// No description provided for @enterLifespan.
  ///
  /// In ru, this message translates to:
  /// **'Введите продолжительность жизни'**
  String get enterLifespan;

  /// No description provided for @lifespanFormatError.
  ///
  /// In ru, this message translates to:
  /// **'Неверный формат'**
  String get lifespanFormatError;

  /// No description provided for @ready.
  ///
  /// In ru, this message translates to:
  /// **'Готово'**
  String get ready;

  /// No description provided for @lifespanInterval.
  ///
  /// In ru, this message translates to:
  /// **'Введите целое число от {start} до {end} лет'**
  String lifespanInterval(int start, int end);

  /// No description provided for @registrationUserError.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось создать пользователя'**
  String get registrationUserError;

  /// No description provided for @registrationCalendarError.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось создать календарь'**
  String get registrationCalendarError;

  /// No description provided for @errorEmptyField.
  ///
  /// In ru, this message translates to:
  /// **'Поле не может быть пустым'**
  String get errorEmptyField;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
