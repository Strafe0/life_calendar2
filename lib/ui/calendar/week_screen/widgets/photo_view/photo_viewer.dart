import 'dart:io' show File;

import 'package:flutter/material.dart';
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

class _PhotoViewerState extends State<PhotoViewer> {
  late final _pageController = PageController(initialPage: widget.initialIndex);

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
          ),
          // TODO: change to dot indicators
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Image ${_pageController.hasClients ? _pageController.page : ''}',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
