import 'package:life_calendar2/data/repositories/user_repository/user_repository.dart';
import 'package:life_calendar2/domain/models/user/user.dart';
import 'package:life_calendar2/utils/result.dart';

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
}
