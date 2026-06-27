/// Repository over app-level settings and launch-state flags, so presentation
/// reads them through the data layer instead of touching the prefs service.
abstract class SettingsRepository {
  Future<bool> isFirstLaunch();

  Future<bool> isFirstLaunchV3();

  Future<void> setFirstLaunchV3({required bool isFirstLaunch});

  Future<int?> getLifespan();
}
