import 'package:flutter/material.dart';
import 'package:life_calendar2/domain/models/onboarding/onboarding_page.dart';

class OnboardingPageWidget extends StatelessWidget {
  const OnboardingPageWidget({super.key, required this.page});

  final OnboardingPage page;

  @override
  Widget build(BuildContext context) {
    final image = page.image;
    final title = page.title;

    return Column(
      children: [
        if (image != null)
          Expanded(child: Image.asset(image)),
        if (title != null)
          Text(title),
        Text(page.content),
      ],
    );
  }
}