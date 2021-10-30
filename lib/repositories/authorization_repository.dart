import 'package:local_auth/local_auth.dart';

abstract class AuthorizationRepository {
  Future<bool> login(String username, String password);

  Future<void> register(String email, String username, String password);

  Future<bool> canDeviceUseBiometrics();

  Future<bool> authenticateUsingBiometrics(String reason);
}

class AuthorizationRepositoryImpl extends AuthorizationRepository {
  final LocalAuthentication localAuthentication;

  AuthorizationRepositoryImpl(this.localAuthentication);

  @override
  Future<bool> login(String username, String password) async {
    return true;
  }

  @override
  Future<void> register(String email, String username, String password) async {}

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
