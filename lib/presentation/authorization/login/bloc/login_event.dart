part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginUser extends LoginEvent {
  final String username;
  final String password;

  LoginUser({required this.username, required this.password});
}

class TryLoginOnStart extends LoginEvent {
  TryLoginOnStart();
}
