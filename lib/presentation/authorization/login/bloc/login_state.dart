part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final bool shouldShowOnboarding;

  LoginSuccess({required this.shouldShowOnboarding});
}

class LoginError extends LoginState {}
