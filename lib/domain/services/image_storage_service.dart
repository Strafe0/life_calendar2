/// Resolves stored photo references (basenames) to absolute paths inside the
/// app's image directory. Keeps filesystem/path_provider IO out of repositories.
abstract interface class ImageStorageService {
  Future<List<String>> resolvePaths(List<String> photos);
}
