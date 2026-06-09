import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:phicore/core/services/storage/i_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferences + FlutterSecureStorage birleşik storage servisi.
class StorageService implements IStorageService {
  static final StorageService _instance = StorageService._init();
  static StorageService get instance => _instance;

  late SharedPreferences _prefs;
  final FlutterSecureStorage _secure = const FlutterSecureStorage();

  StorageService._init();

  /// Uygulama başlangıcında çağrılmalı.
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ════════════════════════════════════
  //  SharedPreferences
  // ════════════════════════════════════

  @override
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    return _prefs.getString(key);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  @override
  Future<bool?> getBool(String key) async {
    return _prefs.getBool(key);
  }

  @override
  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  @override
  Future<int?> getInt(String key) async {
    return _prefs.getInt(key);
  }

  @override
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  @override
  Future<void> clear() async {
    await _prefs.clear();
  }

  // ════════════════════════════════════
  //  Secure Storage (token, hassas veri)
  // ════════════════════════════════════

  @override
  Future<void> setSecure(String key, String value) async {
    await _secure.write(key: key, value: value);
  }

  @override
  Future<String?> getSecure(String key) async {
    return await _secure.read(key: key);
  }

  @override
  Future<void> removeSecure(String key) async {
    await _secure.delete(key: key);
  }

  @override
  Future<void> clearSecure() async {
    await _secure.deleteAll();
  }
}
