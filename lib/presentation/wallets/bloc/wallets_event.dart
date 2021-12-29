part of 'wallets_bloc.dart';

@immutable
abstract class WalletsEvent {}

class ChooseNewWallet extends WalletsEvent {
  int chosenWallet;

  ChooseNewWallet({required this.chosenWallet});
}
