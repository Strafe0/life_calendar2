import 'package:life_calendar/data/repositories/user_repository/user_repository.dart';
import 'package:life_calendar/domain/models/user/user.dart';
import 'package:life_calendar/utils/result.dart';

class UserRepositoryMock implements UserRepository {
  @override
  Future<Result<void>> createUser(User user) {
    return Future.delayed(
      const Duration(milliseconds: 500),
      () => const Result.ok(null),
    );
  }

  @override
  Future<Result<User>> getUser() {
    return Future.delayed(
      const Duration(milliseconds: 500),
      () => Result.ok(
        User.empty(),
        // User(id: 'mock_id', birthday: DateTime(1998, 12, 22), lifeSpan: 80),
      ),
    );
  }

  @override
  Future<Result<void>> increaseLifeSpan({
    required int oldLifeSpan,
    required int newLifeSpan,
  }) {
    return Future.delayed(
      const Duration(milliseconds: 500),
      () => const Result.ok(null),
    );
  }

  @override
  Future<Result<void>> reduceLifeSpan({
    required int oldLifeSpan,
    required int newLifeSpan,
  }) {
    return Future.delayed(
      const Duration(milliseconds: 500),
      () => const Result.ok(null),
    );
  }
}
