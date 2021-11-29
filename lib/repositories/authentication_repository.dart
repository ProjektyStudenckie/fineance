import 'dart:convert';
import 'package:crypt/crypt.dart';
import 'package:dio/dio.dart';
import 'package:fineance/data/network/api_error/api_error.dart';
import 'package:fineance/networking/api_client.dart';
import 'package:fineance/repositories/storage_repository.dart';
import 'package:fineance/repositories/user.dart';
import 'package:local_auth/local_auth.dart';

abstract class AuthenticationRepository {
  Future<bool> login(String username, String password);

  Future<void> register(String email, String username, String password);

  Future<void> refreshToken();

  Future<bool> canDeviceUseBiometrics();

  Future<bool> authenticateUsingBiometrics(String reason);
}

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final ApiClient _apiClient;
  final LocalAuthentication _localAuthentication;
  final StorageService _storageService;

  AuthenticationRepositoryImpl(
      this._apiClient, this._localAuthentication, this._storageService);

  String get _salt => "fineance";

  @override
  Future<bool> login(String username, String password) async {
    try {
      final auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

      final response = await _apiClient.login(auth);

      if (response.accessToken != null && response.refreshToken != null) {
        _storageService.saveTokens(
            response.accessToken ?? "", response.refreshToken ?? "");
        return true;
      }
    } on DioError catch (error) {
      throw ApiError.fromJson(error.response?.data as Map<String, dynamic>);
    }
    return false;
  }

  @override
  Future<bool> register(String email, String username, String password) async {
    try {

      User user = User(username: username, password: password, email: email);

      final response = await _apiClient.registration(user);

      if (response.accessToken != null && response.refreshToken != null) {
        _storageService.saveTokens(
            response.accessToken ?? "", response.refreshToken ?? "");
        return true;
      }
    } on DioError catch (error) {
      throw ApiError.fromJson(error.response?.data as Map<String, dynamic>);
    }
    return false;
  }

  @override
  Future<void> refreshToken() async {
    try {
      final refreshToken = _storageService.getRefreshToken();
      final response = await _apiClient.refreshTokens(refreshToken);

      _storageService.saveTokens(
          response.accessToken ?? "", response.refreshToken ?? "");
    } on DioError catch (error) {
      throw ApiError.fromJson(error.response?.data as Map<String, dynamic>);
    }
  }

  @override
  Future<bool> canDeviceUseBiometrics() async {
    return _localAuthentication.canCheckBiometrics;
  }

  @override
  Future<bool> authenticateUsingBiometrics(String reason) async {
    return _localAuthentication.authenticate(
        localizedReason: reason, biometricOnly: true);
  }
}
