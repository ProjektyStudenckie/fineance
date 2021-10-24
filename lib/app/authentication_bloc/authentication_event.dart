part of 'authentication_bloc.dart';

// @immutable
// abstract class AuthenticationEvent {}
//
// class LoginUser extends AuthenticationEvent {
//   final String username;
//   final String password;
//
//   LoginUser({required this.username, required this.password});
// }

@immutable
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
