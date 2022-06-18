import 'package:dio/dio.dart';
import 'package:test_val/service/secure_storage_service.dart';

import 'package:test_val/constant/constant.dart';

class DioService {
  static final DioService _instance = DioService._internal();
  final Dio dioWOToken;
  final Dio dioWToken;

  DioService._internal()
      : dioWOToken = Dio(),
        dioWToken = Dio() {
    BaseOptions optionsNoToken = BaseOptions(
      baseUrl: "http://10.0.2.2:8080/api/v1",
    );
    BaseOptions optionsToken = BaseOptions(
      baseUrl: "http://10.0.2.2:8080/api/v1/secure",
    );
    dioWOToken.options = optionsNoToken;
    dioWToken.options = optionsToken;
    dioWToken.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      SecureStorageService secureStorageService =
          SecureStorageService.getInstance;
      String? token = await secureStorageService.get(key: "token");
      options.headers[Constants.authenticationHeaderName] =
          Constants.headerPrefix + token!;
      handler.next(options);
    }));
  }

  static Dio get withToken => _instance.dioWToken;

  static Dio get withoutToken => _instance.dioWOToken;
}
