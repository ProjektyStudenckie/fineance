part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

class SplashLoading extends SplashState {}

class SplashOpenHome extends SplashState {}

class SplashOpenBiometrics extends SplashState {}
