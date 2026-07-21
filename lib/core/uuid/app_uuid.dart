import 'dart:math';

/// Generates opaque, locally unique ids for goals, events and the user record.
///
/// Ids are only ever compared for equality and stored as-is, so the format is
/// free to change: values produced by earlier versions (UUIDv1) stay valid.
class AppUuid {
  static final Random _random = Random.secure();

  /// A time-prefixed id: microsecond timestamp plus 64 random bits.
  ///
  /// The timestamp prefix keeps ids roughly ordered by creation time; the
  /// random suffix makes a collision within the same microsecond implausible.
  static String generateTimeBasedUuid() {
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    return '${timestamp.toRadixString(16)}-${_randomHex()}-${_randomHex()}';
  }

  static String _randomHex() =>
      _random.nextInt(0x100000000).toRadixString(16).padLeft(8, '0');
}
