part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class ChosenWallet extends HomeState {
  final Wallet wallet;

  ChosenWallet({required this.wallet});
}
