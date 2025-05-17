import 'package:flutter/material.dart';
import 'package:life_calendar2/domain/models/onboarding/onboarding_page.dart';
import 'package:life_calendar2/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/core/widgets/page_indicator.dart';
import 'package:life_calendar2/ui/onboarding/widgets/onboarding_page_widget.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key, required this.pages});

  final List<OnboardingPage> pages;

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView>
    with TickerProviderStateMixin {
  final _pageController = PageController();
  late final _tabController = TabController(
    length: widget.pages.length,
    vsync: this,
  );
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(onPressed: () {}, child: Text(context.l10n.skip)),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: widget.pages
                  .map((page) => OnboardingPageWidget(page: page))
                  .toList(growable: false),
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
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }
}
