part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final bool shouldShowOnboarding;

  LoginSuccess({required this.shouldShowOnboarding});

  @override
  List<Object?> get props => [shouldShowOnboarding];
}

class LoginIncorrect extends LoginState {}

class LoginError extends LoginState {}
