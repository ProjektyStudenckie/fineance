import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

abstract class AuthenticationRepository {
  Stream<AuthenticationStatus> get status;

  Future<void> logIn({required String username, required String password});

  Future<void> register({
    required String email,
    required String username,
    required String password,
  });

  void logOut();

  void dispose();
}

class AuthorizationRepositoryImpl extends AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  @override
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  @override
  Future<void> logIn(
      {required String username, required String password}) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  @override
  Future<void> register({
    required String email,
    required String username,
    required String password,
  }) async {}

  @override
  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  @override
  void dispose() => _controller.close();
}
