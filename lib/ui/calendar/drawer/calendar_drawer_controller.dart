import 'package:flutter/widgets.dart';

/// Drives the calendar drawer's open fraction (0 = closed, 1 = open) so a
/// horizontal drag over the calendar can pull the drawer out under the finger,
/// instead of snapping it open at a threshold.
class CalendarDrawerController {
  CalendarDrawerController(this.animation);

  /// 0 = fully closed, 1 = fully open. Owned by the screen; exposed so the
  /// drawer panel and scrim can rebuild against it.
  final AnimationController animation;

  /// Current drawer width in logical pixels; maps finger travel to the open
  /// fraction. Updated by the host on layout.
  double drawerWidth = 300;

  /// Follows the finger: [dx] is rightward travel since the drag was claimed.
  void openDrag(double dx) {
    animation.value = (dx / drawerWidth).clamp(0.0, 1.0);
  }

  /// Settles open or closed on release, honouring a fast fling.
  void endDrag(double velocityX) {
    final normalized = velocityX / drawerWidth;
    if (normalized.abs() >= 0.6) {
      animation.fling(velocity: normalized);
    } else {
      animation.fling(velocity: animation.value >= 0.5 ? 1 : -1);
    }
  }

  void open() => animation.fling(velocity: 1);

  void close() => animation.fling(velocity: -1);
}
