import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/domain/services/image_picker_service.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_fab/week_fab_state_provider.dart';

class PhotoFab extends StatefulWidget {
  const PhotoFab({super.key});

  @override
  State<PhotoFab> createState() => _PhotoFabState();
}

class _PhotoFabState extends State<PhotoFab> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: null,
      backgroundColor: Theme.of(context).cardTheme.color,
      foregroundColor: Theme.of(context).colorScheme.primary,
      onPressed: _addPhoto,
      label: Text(context.l10n.photo),
      icon: const Icon(Icons.photo),
    );
  }

  Future<void> _addPhoto() async {
    final weekCubit = context.read<WeekCubit>();
    final fabState = WeekFabStateProvider.of(context);
    final imagePicker = context.read<ImagePickerService>();

    final list = await imagePicker.pickMultipleImages();
    await weekCubit.addPhotos(list);

    fabState.close();
  }
}
