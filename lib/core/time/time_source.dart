/// A function returning the current time.
///
/// Inject a [TimeSource] instead of calling `DateTime.now()` directly so that
/// time-dependent logic (calendar generation, age, etc.) stays deterministic in
/// tests. Production code uses [systemTime]; tests pass a fixed-time function.
typedef TimeSource = DateTime Function();

/// The default [TimeSource] backed by the real system clock.
DateTime systemTime() => DateTime.now();
