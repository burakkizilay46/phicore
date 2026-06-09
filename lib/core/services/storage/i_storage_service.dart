/// Storage service interface.
abstract class IStorageService {
  // ── SharedPreferences ──
  Future<void> setString(String key, String value);
  Future<String?> getString(String key);
  Future<void> setBool(String key, bool value);
  Future<bool?> getBool(String key);
  Future<void> setInt(String key, int value);
  Future<int?> getInt(String key);
  Future<void> remove(String key);
  Future<void> clear();

  // ── Secure Storage ──
  Future<void> setSecure(String key, String value);
  Future<String?> getSecure(String key);
  Future<void> removeSecure(String key);
  Future<void> clearSecure();
}
