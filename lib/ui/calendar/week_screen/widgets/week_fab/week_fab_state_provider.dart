import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:life_calendar2/core/logger/logger.dart';

class WeekFabStateProvider extends InheritedWidget {
  WeekFabStateProvider({super.key, required super.child});

  final _fabKey = GlobalKey<ExpandableFabState>();

  GlobalKey<ExpandableFabState> get fabKey => _fabKey;

  static WeekFabStateProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<WeekFabStateProvider>();
  }

  static WeekFabStateProvider of(BuildContext context) {
    final WeekFabStateProvider? result = maybeOf(context);
    assert(result != null, 'No WeekFabProvider found in context');
    return result!;
  }

  void close() {
    final state = _fabKey.currentState;
    if (state != null) {
      logger.d('FAB close');
      state.close();
    } else {
      logger.w('Cannot close FAB');
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
