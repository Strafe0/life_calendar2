import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';

class SearchPullIndicator extends StatefulWidget {
  const SearchPullIndicator({
    super.key,
    required this.onSearchPulled,
    required this.child,
  });

  final Future<void> Function() onSearchPulled;
  final Widget child;

  static const indicatorSize = 84.0;

  @override
  State<SearchPullIndicator> createState() => _SearchPullIndicatorState();
}

class _SearchPullIndicatorState extends State<SearchPullIndicator> {
  bool _hapticTriggered = false;

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      offsetToArmed: SearchPullIndicator.indicatorSize,
      onStateChanged: (change) {
        if (change.newState.isArmed && !_hapticTriggered) {
          HapticFeedback.lightImpact();
          _hapticTriggered = true;
        }
      },
      onRefresh: () async {
        _hapticTriggered = false;
        await widget.onSearchPulled();
      },
      builder: (context, child, controller) {
        return Stack(
          children: [
            SizedBox(
              height: SearchPullIndicator.indicatorSize * controller.value,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: AnimatedRotation(
                          turns:
                              controller.isDragging || controller.isIdle
                                  ? 0
                                  : 1 / 2,
                          duration: const Duration(milliseconds: 100),
                          child: Icon(
                            Icons.arrow_downward,
                            size: 24 * controller.value.clamp(0, 1),
                            color:
                                controller.isDragging || controller.isIdle
                                    ? ColorScheme.of(context).onSurface
                                    : Colors.green,
                          ),
                        ),
                      ),
                      if (controller.isDragging || controller.isIdle)
                        Text(context.l10n.pullToSearch)
                      else
                        Text(
                          context.l10n.releaseToSearch,
                          style: TextTheme.of(
                            context,
                          ).bodyMedium?.copyWith(color: Colors.green),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(
                    0,
                    controller.value * SearchPullIndicator.indicatorSize,
                  ),
                  child: child,
                );
              },
              animation: controller,
            ),
          ],
        );
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(height: constraints.maxHeight, child: widget.child),
          );
        },
      ),
    );
  }
}
