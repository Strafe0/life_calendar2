import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_state.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_photos/photo_widget.dart';

class WeekPhotoListWidget extends StatelessWidget {
  const WeekPhotoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.only(left: 12, bottom: 4),
          sliver: SliverToBoxAdapter(
            child: Text(
              'Фото',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.start,
            ),
          ),
        ),
        BlocBuilder<WeekCubit, WeekState>(
          builder: (context, state) {
            final photos = state is WeekSuccess ? state.week.photos : [];

            if (photos.isEmpty) {
              return const SliverToBoxAdapter(
                child: Center(child: Text('Нет фото')),
              );
            }

            return SliverGrid.builder(
              itemCount: photos.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (_, index) => PhotoWidget(photoUrl: photos[index]),
            );
          },
        ),
      ],
    );
  }
}
