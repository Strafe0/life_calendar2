import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class CrashlyticsNavigationObserver extends NavigatorObserver {
  void _logScreenView(Route<dynamic> route, String action) {
    final screenName = route.settings.name ?? 'Anonymous/Dialog/Drawer...';

    FirebaseCrashlytics.instance.log('$action: $screenName');

    FirebaseCrashlytics.instance.setCustomKey('current_screen', screenName);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _logScreenView(route, 'Push');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      _logScreenView(newRoute, 'Replace');
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null) {
      _logScreenView(previousRoute, 'Pop (Back to)');
    }
  }
}
