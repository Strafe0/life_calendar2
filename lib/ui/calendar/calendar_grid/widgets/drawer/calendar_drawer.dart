import 'package:flutter/material.dart';

class CalendarDrawer extends StatelessWidget {
  const CalendarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      header: Text('header'),
      footer: Text('footer'),
      children: [Text('child 1'), Text('child 2')],
    );
  }
}
