import 'dart:io' show File;

import 'package:flutter/material.dart';
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
  late final _pageController = PageController(initialPage: widget.initialIndex);
  late final _tabController = TabController(
    length: widget.photoPathList.length,
    vsync: this,
  );
  late int _currentIndex = widget.initialIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            pageController: _pageController,
            itemCount: widget.photoPathList.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: FileImage(File(widget.photoPathList[index])),
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
          // TODO: fix initial index
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 100,
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
        ],
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
