import 'package:equatable/equatable.dart';

class OnboardingPage extends Equatable {
  /// Url or path
  final String? image;
  final String? title;
  final String content;

  const OnboardingPage({
    required this.image,
    required this.title,
    required this.content,
  });

  @override
  List<Object?> get props => [image, title, content];
}
