import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {

  static const SecureStorageService _instance =
       SecureStorageService._internal();
   final FlutterSecureStorage flutterSecureStorage;


  const SecureStorageService._internal()
      : flutterSecureStorage = const FlutterSecureStorage();



  static SecureStorageService get getInstance => _instance;


  Future<void> set({required String key, required String value})  {
    return flutterSecureStorage.write(key: key, value: value);
  }

  Future<String?> get({required String key}) {
    return flutterSecureStorage.read(key: key);
  }
}
