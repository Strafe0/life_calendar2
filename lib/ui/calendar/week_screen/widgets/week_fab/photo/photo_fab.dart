import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/domain/services/image_picker_service.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_ad/week_ad_bloc.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_ad/week_ad_event.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_ad/week_ad_source_enum.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_ad/week_ad_state.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_fab/week_fab_state_provider.dart';
import 'package:life_calendar2/ui/core/dialogs/error_dialog.dart';

class PhotoFab extends StatelessWidget {
  const PhotoFab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeekAdBloc, WeekAdState>(
      listener: (context, state) {
        if (state is WeekAdShowSuccess && state.source.isPhotos) {
          _addPhoto(context);
        }
      },
      child: FloatingActionButton.extended(
        heroTag: null,
        backgroundColor: Theme.of(context).cardTheme.color,
        foregroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          final weekCubit = context.read<WeekCubit>();

          if (weekCubit.isPhotosExceededLimit) {
            context.read<WeekAdBloc>().add(
              const WeekAdShowRequested(source: WeekAdSource.photos),
            );

            return;
          }

          _addPhoto(context);
        },
        label: Text(context.l10n.photo),
        icon: const Icon(Icons.photo),
      ),
    );
  }

  Future<void> _addPhoto(BuildContext context) async {
    final weekCubit = context.read<WeekCubit>();
    final fabState = WeekFabStateProvider.of(context);
    final imagePicker = context.read<ImagePickerService>();

    final file = await imagePicker.pickImage();

    if (file == null) {
      if (context.mounted) {
        showErrorDialog(
          context,
          title: context.l10n.error,
          content: context.l10n.errorPhotoAttach,
        );
      }
      return;
    }

    await weekCubit.addPhotos(file);

    fabState.close();
  }
}
