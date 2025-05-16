import 'package:flutter/material.dart';

class OnboardingLoadingView extends StatelessWidget {
  const OnboardingLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: CircularProgressIndicator(),
          ),
          Text('Загрузка'),
        ],
      ),
    );
  }
}
