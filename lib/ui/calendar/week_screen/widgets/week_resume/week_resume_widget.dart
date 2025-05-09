import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_state.dart';

class WeekResumeWidget extends StatelessWidget {
  const WeekResumeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.only(left: 12, bottom: 4),
          sliver: SliverToBoxAdapter(
            child: Text(
              'Итог',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.start,
            ),
          ),
        ),
        BlocSelector<WeekCubit, WeekState, String>(
          selector: (weekState) {
            if (weekState is WeekSuccess) {
              return weekState.week.resume;
            }
            return '';
          },
          builder: (context, resume) {
            if (resume.isEmpty) {
              return const SliverToBoxAdapter(
                child: Center(child: Text('Нет итога')),
              );
            }

            return SliverToBoxAdapter(
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 0, 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          resume,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      PopupMenuButton<int>(
                        icon: Icon(
                          Icons.more_vert,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        onSelected: (value) {
                          if (value == 1) {
                            // TODO: change resume
                          } else if (value == 2) {
                            // TODO: delete resume
                          }
                        },
                        itemBuilder:
                            (context) => [
                              PopupMenuItem(
                                value: 1,
                                child: Text(
                                  'Изменить',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              PopupMenuItem(
                                value: 2,
                                child: Text(
                                  'Удалить',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
