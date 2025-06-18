import 'package:flutter/material.dart';

class CalendarViewLoadingBody extends StatelessWidget {
  const CalendarViewLoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
