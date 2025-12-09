import 'package:flutter/material.dart';
import 'package:life_calendar2/core/constants/constants.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/core/logger/logger.dart';
import 'package:life_calendar2/ui/core/snackbars/error_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.feedback),
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                context.l10n.leaveReviewMessage,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) =>
                      const Icon(Icons.star, color: Colors.yellow, size: 32),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                context.l10n.writeFeedbackToMail,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => _writeToMail(context),
                child: Text(context.l10n.writeButton),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _writeToMail(BuildContext context) async {
    final uri = Uri.parse(mailScheme);

    bool isSuccess = true;
    try {
      isSuccess = await launchUrl(uri);
    } catch (e) {
      logger.e('Failed to write to mail', error: e);
      isSuccess = false;
    }

    if (!isSuccess) {
      if (!context.mounted) return;
      showErrorSnackBar(context, text: context.l10n.errorWriteFeedback);
    }
  }
}
