import 'dart:convert';
import 'package:crypt/crypt.dart';
import 'package:dio/dio.dart';
import 'package:fineance/data/network/api_error/api_error.dart';
import 'package:fineance/networking/api_client.dart';
import 'package:local_auth/local_auth.dart';

abstract class AuthenticationRepository {
  Future<bool> login(String username, String password);

  Future<void> register(String email, String username, String password);

  Future<bool> canDeviceUseBiometrics();

  Future<bool> authenticateUsingBiometrics(String reason);
}

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final ApiClient _apiClient;
  final LocalAuthentication localAuthentication;

  AuthenticationRepositoryImpl(this._apiClient, this.localAuthentication);

  String get _salt => "fineance";

  @override
  Future<bool> login(String username, String password) async {
    try {
      final auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

      final response = await _apiClient.login(auth);

      // final crypt = Crypt.sha256(password, salt: _salt);
      if (response.accessToken != null) {
        return true;
      }
    } on DioError catch (error) {
      throw ApiError.fromJson(error.response?.data as Map<String, dynamic>);
    }
    return false;
  }

  @override
  Future<void> register(String email, String username, String password) async {
    final crypt = Crypt.sha256(password, salt: _salt);
  }

  @override
  Future<bool> canDeviceUseBiometrics() async {
    return localAuthentication.canCheckBiometrics;
  }

  @override
  Future<bool> authenticateUsingBiometrics(String reason) async {
    return localAuthentication.authenticate(
        localizedReason: reason, biometricOnly: true);
  }
}
