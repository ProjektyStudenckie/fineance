part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

class SplashLoading extends SplashState {}

class SplashOpenHome extends SplashState {}

class SplashOpenRegisterIncomeExpense extends SplashState {}

class SplashOpenBiometrics extends SplashState {
  final FineanceQuickActions? quickAction;

  SplashOpenBiometrics([this.quickAction]);
}
