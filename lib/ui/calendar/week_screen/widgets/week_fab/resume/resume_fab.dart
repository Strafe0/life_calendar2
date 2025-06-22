import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:life_calendar2/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_state.dart';

class ResumeFab extends StatefulWidget {
  const ResumeFab({super.key, this.closeFab});

  final VoidCallback? closeFab;

  @override
  State<ResumeFab> createState() => _ResumeFabState();
}

class _ResumeFabState extends State<ResumeFab> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();

    final weekState = context.read<WeekCubit>().state;
    if (weekState is WeekSuccess) {
      _textController = TextEditingController(text: weekState.week.resume);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: null,
      backgroundColor: Theme.of(context).cardTheme.color,
      foregroundColor: Theme.of(context).colorScheme.primary,
      onPressed: _addResume,
      label: Text(context.l10n.resume),
      icon: const Icon(Icons.edit),
    );
  }

  Future<void> _addResume() async {
    final weekCubit = context.read<WeekCubit>();

    await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.8,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height / 4,
                child: Column(
                  children: [
                    Text(
                      context.l10n.resume,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextField(
                          controller: _textController,
                          expands: true,
                          maxLines: null,
                          autofocus: true,
                          textAlignVertical: TextAlignVertical.top,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onEditingComplete: () async {
                            await weekCubit.changeResume(_textController.text);
                            if (context.mounted) {
                              context.pop();
                              if (widget.closeFab != null) {
                                widget.closeFab?.call();
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
