part of 'wallets_bloc.dart';

@immutable
abstract class WalletsEvent {}

class ChooseNewWallet extends WalletsEvent {
  final int chosenWallet;

  ChooseNewWallet({required this.chosenWallet});
}
