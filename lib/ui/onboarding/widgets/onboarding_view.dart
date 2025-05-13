import 'package:flutter/material.dart';
import 'package:life_calendar2/domain/models/onboarding/onboarding_page.dart';
import 'package:life_calendar2/ui/onboarding/widgets/onboarding_page_widget.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key, required this.pages});

  final List<OnboardingPage> pages;

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: widget.pages
          .map(
            (page) => Padding(
              padding: const EdgeInsets.all(16),
              child: OnboardingPageWidget(page: page),
            ),
          )
          .toList(growable: false),
    );
  }
}
