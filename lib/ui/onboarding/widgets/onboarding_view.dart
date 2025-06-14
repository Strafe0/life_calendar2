import 'package:flutter/material.dart';
import 'package:life_calendar2/domain/models/onboarding/onboarding_page.dart';
import 'package:life_calendar2/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/core/widgets/page_indicator.dart';
import 'package:life_calendar2/ui/onboarding/widgets/onboarding_page_widget.dart';
import 'package:life_calendar2/ui/registration/widgets/registration_page.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key, required this.pages});

  final List<OnboardingPage> pages;

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView>
    with TickerProviderStateMixin {
  int get totalPageCount => widget.pages.length + 1; // + registration

  final _pageController = PageController();
  late final _tabController = TabController(
    length: totalPageCount,
    vsync: this,
  );
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed:
                () => _pageController.animateToPage(
                  widget.pages.length,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.fastOutSlowIn,
                ),
            child: Text(
              context.l10n.skip,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(122),
              ),
            ),
          ),
        ),
        Expanded(
          child: PageView.builder(
            itemCount: totalPageCount,
            controller: _pageController,
            itemBuilder: (context, i) {
              if (i == widget.pages.length) {
                return const RegistrationPage();
              }
              return OnboardingPageWidget(page: widget.pages[i]);
            },
            onPageChanged: (newPageIndex) {
              setState(() {
                _tabController.index = newPageIndex;
                _pageIndex = newPageIndex;
              });
            },
          ),
        ),
        PageIndicator(
          currentPageIndex: _pageIndex,
          tabController: _tabController,
          onUpdateCurrentPageIndex: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }
}
