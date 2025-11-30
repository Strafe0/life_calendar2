import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/core/navigation/app_routes.dart';
import 'package:life_calendar2/domain/models/onboarding/onboarding_page.dart';
import 'package:life_calendar2/domain/services/local_backup_service.dart';
import 'package:life_calendar2/ui/core/snackbars/error_snack_bar.dart';
import 'package:life_calendar2/ui/core/widgets/page_indicator.dart';
import 'package:life_calendar2/ui/onboarding/widgets/onboarding_page_widget.dart';
import 'package:life_calendar2/ui/registration/widgets/registration_page.dart';
import 'package:life_calendar2/utils/result.dart';

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
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              TextButton(
                onPressed:
                    () => _pageController.animateToPage(
                      widget.pages.length,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.fastOutSlowIn,
                    ),
                child: Text(
                  context.l10n.skip,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(122),
                  ),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () async {
                  final result =
                      await context.read<LocalBackupService>().importCalendar();

                  if (!context.mounted) {
                    logger.w('Context is not mounted');
                    return;
                  }

                  if (result is Ok<bool> && result.value) {
                    context.go(AppRoute.calendar);
                  } else {
                    showErrorSnackBar(context, text: context.l10n.errorImport);
                  }
                },
                child: Text(context.l10n.importDialogTitle),
              ),
            ],
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
