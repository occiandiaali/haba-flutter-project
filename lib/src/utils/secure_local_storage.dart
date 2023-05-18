import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageItem {
  StorageItem(this.key, this.value);

  final String key;
  final String value;
}

class SecureLocalStorage {
  // Create storage
  final _storage = const FlutterSecureStorage();

  // Write value
  Future<void> writeSecureData(StorageItem newItem) async {
    await _storage.write(
        key: newItem.key,
        value: newItem.value,
        aOptions: _getAndroidOptions()
    );
  }

  // Read value
  Future<String?> readSecureData(String key) async {
    var readData = await _storage.read(
        key: key,
        aOptions: _getAndroidOptions()
    );
    return readData;
  }

  // Delete value
  // Future<void> deleteSecureData(StorageItem item) async {
  //   await _storage.delete(key: item.key, aOptions: _getAndroidOptions());
  // }
  Future<void> deleteSecureData(String key) async {
    await _storage.delete(key: key, aOptions: _getAndroidOptions());
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );

}
