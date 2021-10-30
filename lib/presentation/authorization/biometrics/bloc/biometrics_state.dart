part of 'biometrics_bloc.dart';

@immutable
abstract class BiometricsState {}

class BiometricsInitial extends BiometricsState {}

class AuthSuccess extends BiometricsState {}

class AuthError extends BiometricsState {}
