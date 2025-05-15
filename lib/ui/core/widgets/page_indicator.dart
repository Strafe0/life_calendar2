import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.currentPageIndex,
    required this.tabController,
    required this.onUpdateCurrentPageIndex,
  });

  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Visibility(
          visible: currentPageIndex > 0,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: IconButton(
            onPressed: () {
              onUpdateCurrentPageIndex(currentPageIndex - 1);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: TabPageSelector(
              controller: tabController,
              color: colorScheme.outline.withAlpha(122),
              selectedColor: colorScheme.primary,
              borderStyle: BorderStyle.none,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            onUpdateCurrentPageIndex(currentPageIndex + 1);
          },
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
