import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:life_calendar/core/extensions/brightness_extension.dart';
import 'package:life_calendar/ui/core/widgets/page_indicator.dart';

class PhotoViewer extends StatefulWidget {
  const PhotoViewer({
    super.key,
    required this.photoPathList,
    required this.initialIndex,
  });

  final List<String> photoPathList;
  final int initialIndex;

  @override
  State<PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer>
    with TickerProviderStateMixin {
  late final PageController _pageController;
  late final TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: widget.initialIndex);
    _tabController = TabController(
      initialIndex: widget.initialIndex,
      length: widget.photoPathList.length,
      vsync: this,
    );

    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).colorScheme.surface,
        statusBarIconBrightness: Theme.brightnessOf(context).inverse,
        statusBarBrightness: Theme.brightnessOf(context).inverse,
      ),
      child: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.photoPathList.length,
          onPageChanged: (index) {
            setState(() {
              _tabController.index = index;
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            final currentPath = widget.photoPathList[index];
            return Dismissible(
              key: ValueKey(currentPath),
              direction: DismissDirection.down,
              dismissThresholds: const {DismissDirection.down: 0.2},
              onDismissed: (direction) => Navigator.pop(context),
              resizeDuration: null,
              child: ColoredBox(
                color: Theme.of(context).colorScheme.surface,
                child: Stack(
                  children: [
                    Center(
                      child: Hero(
                        tag: currentPath,
                        child: Image.file(File(currentPath)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 56,
                        child: PageIndicator(
                          currentPageIndex: _currentIndex,
                          tabController: _tabController,
                          onUpdateCurrentPageIndex: (index) {
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }
}
