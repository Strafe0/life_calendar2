import 'package:equatable/equatable.dart';
import 'package:life_calendar2/core/l10n/app_localizations.dart';

class OnboardingPage extends Equatable {
  /// Url or path
  final String? image;
  final String? Function(AppLocalizations) titleResolver;
  final String Function(AppLocalizations) contentResolver;

  const OnboardingPage({
    required this.image,
    required this.titleResolver,
    required this.contentResolver,
  });

  @override
  List<Object?> get props => [image, titleResolver, contentResolver];
}
