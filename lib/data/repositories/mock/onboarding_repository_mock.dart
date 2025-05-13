import 'package:life_calendar2/domain/models/onboarding/onboarding_page.dart';
import 'package:life_calendar2/domain/repositories/onboarding_repository.dart';
import 'package:life_calendar2/utils/result.dart';

class OnboardingRepositoryMock implements OnboardingRepository {
  @override
  Future<Result<List<OnboardingPage>>> getPages() {
    return Future.delayed(
      const Duration(milliseconds: 100),
      () => const Result.ok([
        OnboardingPage(
          image: 'assets/onboarding/life_calendar_paper.png',
          title: 'Календарь жизни в неделях',
          content:
              'Этот календарь дает наглядное представление о количестве '
              'прожитых и оставшихся неделей нашей жизни.',
        ),
        OnboardingPage(
          image: 'assets/onboarding/onboarding2.png',
          title: 'Календарь жизни в неделях',
          content:
              'Каждая строка календаря соответствует одному году '
              '(52 или 53 недели). Каждый год начинается с недели, которая '
              'содержит ваш день рождения.',
        ),
        OnboardingPage(
          image: 'assets/onboarding/zoom_select.png',
          title: 'Увеличивайте календарь и выбирайте неделю',
          content:
              'Вы можете приблизить календарь. Нажав на квадрат, '
              'вы перейдете на экран выбранной недели.',
        ),
        OnboardingPage(
          image: 'assets/onboarding/onboarding4.png',
          title: 'Переходите к текущей неделе одним нажатием',
          content:
              'Чтобы сразу перейти к текущей неделе, '
              'нажмите на кнопку снизу справа.',
        ),
      ]),
    );
  }
}
