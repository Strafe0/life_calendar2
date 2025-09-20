import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_state.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/photo_view/photo_viewer_error.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewer extends StatefulWidget {
  const PhotoViewer({super.key, this.initialIndex});

  final int? initialIndex;

  @override
  State<PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  late final _pageController = PageController(
    initialPage: widget.initialIndex ?? 0,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeekCubit, WeekState>(
      builder: (context, state) {
        return switch (state) {
          // TODO: improve loading state
          WeekInitial() || WeekLoading() => const CircularProgressIndicator(),
          WeekFailure() => const PhotoViewerError(),
          WeekSuccess() => Scaffold(
            body: Stack(
              children: [
                PhotoViewGallery.builder(
                  pageController: _pageController,
                  itemCount: state.week.photos.length,
                  builder: (context, index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: FileImage(File(state.week.photos[index])),
                      heroAttributes: PhotoViewHeroAttributes(
                        tag: state.week.photos[index],
                      ),
                    );
                  },
                ),
                // TODO: change to dot indicators
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Image ${_pageController.page}'),
                  ),
                ),
              ],
            ),
          ),
        };
      },
    );
  }
}
