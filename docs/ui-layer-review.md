# UI Layer Review

Отдельный проход по слою `lib/ui/` проекта **Life Calendar** (кубиты/блоки и
виджеты). Пункты, которых ещё нет в [`architecture-review.md`](architecture-review.md)
и [`architecture-review-followup.md`](architecture-review-followup.md). Все позиции
ниже — **открытые**.

Дата ревью: 2026-07-03.

---

## Баги

### U1 — Неосвобождённые `TextEditingController` (приоритет: средний) — ИСПРАВЛЕНО

**Исправлено (2026-07-07):** во все четыре `State` добавлен `dispose()` с
освобождением контроллера (`_textController` / `_dateController` /
`_lifeSpanTextController`) перед `super.dispose()` — тот же паттерн, что уже был
у `EventTextField`. `flutter analyze` по изменённым файлам чистый.

Часть виджетов создаёт контроллер в `State`, но не освобождает его в `dispose()`
(утечка нативных ресурсов + слушателей). В соседних виджетах паттерн уже
соблюдён правильно (`EventTextField`, `ChangeLifespanDrawerButton`,
`OnboardingView`, `PhotoViewer` — у них `dispose()` есть), то есть это
пропуски, а не осознанное решение:

- [`resume_text_field.dart`](../lib/ui/calendar/week_screen/widgets/week_resume/resume_text_field.dart)
  (строка 18) — `_textController`, `dispose()` отсутствует полностью. Ср. с
  `EventTextField`, где он реализован.
- [`date_text_field.dart`](../lib/ui/core/widgets/date_text_field.dart)
  (строка 33) — `_dateController`, `dispose()` отсутствует. Виджет создаётся/
  уничтожается часто (регистрация, поиск, sheet событий).
- [`goal_change_sheet.dart`](../lib/ui/calendar/week_screen/widgets/week_goals/goal_change_sheet.dart)
  (строка 17) — `_textController`, `dispose()` отсутствует.
- [`registration_form_body.dart`](../lib/ui/registration/widgets/registration_form_body.dart)
  (строка 22) — `_lifeSpanTextController`, `dispose()` отсутствует.

**Фикс:** добавить `dispose()` с освобождением контроллера в каждом из
перечисленных `State`.

### U2 — `ValueNotifier` не освобождается (приоритет: низкий) — ИСПРАВЛЕНО

**Исправлено (2026-07-07):** в `dispose()` добавлен `_topNotifier.dispose()`
рядом с `_transformationController.dispose()`. `flutter analyze` чистый.

В [`calendar_view_body.dart`](../lib/ui/calendar/calendar_grid/widgets/calendar_view_body.dart)
(`_topNotifier`, строка 38) создаётся `ValueNotifier<double>`, но в `dispose()`
освобождался только `_transformationController`.

### U3 — Слушатель контроллера не снимается в `dispose` (приоритет: низкий) — ИСПРАВЛЕНО

**Исправлено (2026-07-07):** в `dispose()` добавлен
`widget.controller.removeListener(_controllerListener)` перед освобождением
`_animationController` — виджет теперь снимает свой слушатель явно, не полагаясь
на порядок уничтожения владельца контроллера. `flutter analyze` чистый.

В [`calendar_interactive_viewer.dart`](../lib/ui/calendar/calendar_grid/widgets/calendar_interactive_viewer.dart)
`initState` вешает `widget.controller.addListener(_controllerListener)` (строка
38), но `dispose()` снимал только `_animationController` и **не вызывал**
`widget.controller.removeListener(_controllerListener)`.

### U4 — `UserBloc._changeLifeSpan` может «залипнуть» в загрузке (приоритет: низкий) — ИСПРАВЛЕНО

**Исправлено (2026-07-07):** проверка состояния переписана на ранний выход —
`if (currentState is! UserSuccess) { ...log; return; }` **до**
`emit(const UserLoading())`. Теперь при незагруженном пользователе блок не входит
в `UserLoading`, а тело метода развёрнуто из вложенного `if`. `flutter analyze`
чистый.

В [`user_bloc.dart`](../lib/ui/user/bloc/user_bloc.dart)
(`_changeLifeSpan`) `emit(const UserLoading())` вызывался **до** проверки
`if (currentState is UserSuccess)`. Если состояние на момент запроса не
`UserSuccess`, блок эмитил `UserLoading` и дальше ничего не делал и не
восстанавливал состояние — оставался навсегда в `UserLoading`.

---

## Замечания (низкий приоритет)

- **Непоследовательное использование `Equatable`.** — ИСПРАВЛЕНО (2026-07-07).
  По образцу уже существующего `WeekState` `EquatableMixin` добавлен в состояния,
  несущие данные: `CalendarSuccess`/`CalendarFailure`, `UserSuccess`/
  `UserFailure`; `SettingsState` переведён на `extends Equatable` с `const`-
  конструктором. Состояния-синглтоны (`*Initial`/`*Loading`) оставлены на
  `const`-канонизации, как в `WeekState`. Важный нюанс: `lastUpdateTime` **оставлен
  в `props`** `CalendarSuccess`, потому что он одновременно служит триггером
  `CalendarPainter.shouldRepaint` (там `weekBoxes` сравнивается только по длине),
  так что перерисовка при смене содержимого недели сохраняется. `User` — Freezed
  (value-equality), поэтому `props: [user]` сравнивается по значению.
  `flutter analyze` по проекту чистый.
- **Хит-тест по календарю не учитывает вертикальный сдвиг при pull.** —
  ИСПРАВЛЕНО (2026-07-07). В `onTapUp`
  [`calendar_view_body.dart`](../lib/ui/calendar/calendar_grid/widgets/calendar_view_body.dart)
  к результату `_transformationController.toScene(...)` теперь применяется
  `.translate(0, -_topNotifier.value)`, компенсируя тот же сдвиг
  `Transform.translate`, которым смещается полотно `CustomPaint`. В покое
  `_topNotifier.value == 0`, так что обычные тапы не меняются; смещение снимается
  только во время/после pull-жеста. `flutter analyze` чистый.
- **Мутация состояния in-place** в `CalendarCubit.updateWeek` — ИСПРАВЛЕНО
  (2026-07-09). Метод переписан на ранний выход и сборку нового списка
  (`[...currentState.weeks]`) вместо записи в список текущего состояния на месте;
  это убирает и хрупкость, на которую опирался `lastUpdateTime` после перехода
  `CalendarState` на `Equatable`. Замечание также закрыто в
  [`architecture-review-followup.md`](architecture-review-followup.md) (раздел
  «Замечания»). `flutter analyze` чистый.
