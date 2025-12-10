import 'package:flutter/material.dart';
import 'package:life_calendar2/core/constants/constants.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/core/logger/logger.dart';
import 'package:life_calendar2/ui/calendar/drawer/widgets/drawer_item.dart';
import 'package:life_calendar2/ui/calendar/drawer/widgets/drawer_thanks.dart';
import 'package:life_calendar2/ui/core/dialogs/alert_dialog.dart';
import 'package:life_calendar2/ui/core/dialogs/dialog_action.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendarDrawerFooter extends StatelessWidget {
  const CalendarDrawerFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const DrawerThanks(),
          const Divider(indent: 16, endIndent: 16),
          DrawerItem(
            icon: Icons.info_outline,
            title: context.l10n.aboutAppDrawerTitle,
            onPressed: () async {
              final packageInfo = await PackageInfo.fromPlatform();

              final String appName = packageInfo.appName;
              // final String packageName = packageInfo.packageName;
              final String version = packageInfo.version;
              final String buildNumber = packageInfo.buildNumber;

              if (!context.mounted) return;

              showAboutDialog(
                context: context,
                applicationName: appName,
                applicationVersion: '$version ($buildNumber)',
              );
            },
          ),
          DrawerItem(
            icon: Icons.policy_outlined,
            title: context.l10n.privacyPolicy,
            onPressed: () => _goToPrivacyPolicy(context),
          ),
        ],
      ),
    );
  }

  Future<void> _goToPrivacyPolicy(BuildContext context) async {
    final url = Uri.parse(privacyPolicyUrl);

    bool isSuccess = true;
    try {
      isSuccess = await launchUrl(url);
    } catch (e) {
      logger.e('Failed to open Privacy Policy', error: e);
      isSuccess = false;
    }

    if (!isSuccess) {
      if (!context.mounted) return;
      await showAlertDialog(
        context,
        title: context.l10n.error,
        content: context.l10n.errorPrivacyPolicy,
        actions: [
          DialogAction(
            onPressed: (context) => Navigator.of(context).pop(),
            title: context.l10n.gotIt,
          ),
        ],
      );
    }
  }
}
