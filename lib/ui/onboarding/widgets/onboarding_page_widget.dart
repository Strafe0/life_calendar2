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
        if (image != null) Expanded(flex: 10, child: Image.asset(image)),
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        Text(
          page.content,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
      ],
    );
  }
}
