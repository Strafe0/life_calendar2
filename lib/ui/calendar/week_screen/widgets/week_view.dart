import 'package:flutter/material.dart';
import 'package:life_calendar2/domain/models/week/week.dart';

class WeekView extends StatefulWidget {
  const WeekView({super.key, required this.week});

  final Week week;

  @override
  State<WeekView> createState() => _WeekViewState();
}

class _WeekViewState extends State<WeekView> {
  @override
  Widget build(BuildContext context) {
    return const Text('Here will be week');
  }
}