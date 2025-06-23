import 'package:flutter/material.dart';

Future<T?> showDraggableBottomSheet<T>(
  BuildContext context, {
  double initialChildSize = 0.8,
  double maxChildSize = 0.9,
  double? height,
  String? title,
  required Widget Function(BuildContext) builder,
}) {
  return showModalBottomSheet<T>(
    context: context,
    showDragHandle: true,
    useSafeArea: true,
    isScrollControlled: true,
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: initialChildSize,
        maxChildSize: maxChildSize,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: SizedBox(
              height: height ?? MediaQuery.sizeOf(context).height / 4,
              child: Column(
                children: [
                  if (title != null)
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                  Expanded(child: builder(context)),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
