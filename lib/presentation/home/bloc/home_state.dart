part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class ChosenWallet extends HomeState {
  final int chosenWallet;

  ChosenWallet({required this.chosenWallet});
}
