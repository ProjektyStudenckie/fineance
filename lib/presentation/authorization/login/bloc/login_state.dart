part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginChecking extends LoginState {
  final bool isLoginChecking;

  LoginChecking({required this.isLoginChecking});

  @override
  List<Object?> get props => [isLoginChecking];
}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final bool shouldShowOnboarding;

  LoginSuccess({required this.shouldShowOnboarding});

  @override
  List<Object?> get props => [shouldShowOnboarding];
}

class LoginIncorrect extends LoginState {}

class LoginError extends LoginState {}
