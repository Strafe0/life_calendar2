import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_state.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_resume/resume_utils.dart';
import 'package:life_calendar2/ui/core/constants.dart';
import 'package:life_calendar2/ui/core/menus/adaptive_action_menu.dart';

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
              context.l10n.resume,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.start,
            ),
          ),
        ),
        BlocSelector<WeekCubit, WeekState, String>(
          selector: (weekState) {
            if (weekState is WeekSuccess) return weekState.week.resume;
            return '';
          },
          builder: (context, resume) {
            if (resume.isEmpty) {
              return SliverToBoxAdapter(
                child: Center(child: Text(context.l10n.noResume)),
              );
            }

            return SliverToBoxAdapter(
              child: Card(
                shape: shapeBorder,
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
                      AdaptiveActionMenu(
                        editLabel: context.l10n.edit,
                        deleteLabel: context.l10n.delete,
                        cancelLabel: context.l10n.cancel,
                        onEdit: () => showResumeSheet(context),
                        onDelete: () => _deleteResume(context),
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

  Future<void> _deleteResume(BuildContext context) async {
    final weekCubit = context.read<WeekCubit>();
    await weekCubit.deleteResume();
  }
}
