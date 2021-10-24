// abstract class AuthorizationRepository {
//   Future<bool> login(String username, String password);
//
//   Future<void> register(String email, String username, String password);
// }
//
// class AuthorizationRepositoryImpl extends AuthorizationRepository {
//   @override
//   Future<bool> login(String username, String password) async {
//     return true;
//   }
//
//   @override
//   Future<void> register(String email, String username, String password) async {}
// }

import 'dart:async';

abstract class AuthenticationRepository {
  Stream<AuthenticationStatus> get status;

  Future<void> logIn({required String username, required String password});

  void logOut();

  void dispose();
}

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  @override
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  @override
  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  @override
  void logOut() => _controller.add(AuthenticationStatus.unauthenticated);

  @override
  void dispose() => _controller.close();
}

enum AuthenticationStatus { unknown, authenticated, unauthenticated }
