import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    required DateTime birthday,
    required int lifeSpan,
  }) = _User;

  const User._();

  factory User.empty() => _User(
    id: '',
    birthday: DateTime.fromMillisecondsSinceEpoch(0),
    lifeSpan: 0,
  );

  bool get isEmpty => id.isEmpty;
}
