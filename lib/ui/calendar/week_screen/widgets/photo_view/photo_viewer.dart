import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:life_calendar2/core/extensions/theme_extension.dart';
import 'package:life_calendar2/ui/core/widgets/page_indicator.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

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
    // TODO: make page dismissible
    // TODO: add close button
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).colorScheme.surface,
        statusBarIconBrightness: Theme.of(context).inverseBrightness,
        statusBarBrightness: Theme.of(context).inverseBrightness,
      ),
      child: SafeArea(
        child: Scaffold(
          body: Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.down,
            dismissThresholds: const {DismissDirection.down: 0.2},
            onDismissed: (direction) => context.pop(),
            child: Stack(
              children: [
                PhotoViewGallery.builder(
                  pageController: _pageController,
                  itemCount: widget.photoPathList.length,
                  backgroundDecoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  builder: (context, index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: FileImage(
                        File(widget.photoPathList[index]),
                      ),
                      heroAttributes: PhotoViewHeroAttributes(
                        tag: widget.photoPathList[index],
                      ),
                    );
                  },
                  onPageChanged: (index) {
                    setState(() {
                      _tabController.index = index;
                      _currentIndex = index;
                    });
                  },
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
