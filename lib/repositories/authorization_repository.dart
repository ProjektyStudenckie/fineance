abstract class AuthorizationRepository {
  Future<bool> login(String username, String password);

  Future<void> register(String email, String username, String password);
}

class AuthorizationRepositoryImpl extends AuthorizationRepository {
  @override
  Future<bool> login(String username, String password) async {
    return true;
  }

  @override
  Future<void> register(String email, String username, String password) async {}
}
