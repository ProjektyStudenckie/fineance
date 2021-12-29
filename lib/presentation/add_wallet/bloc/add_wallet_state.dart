part of 'add_wallet_bloc.dart';

abstract class AddWalletState extends Equatable {
  const AddWalletState();

  @override
  List<Object> get props => [];
}

class AddWalletInitial extends AddWalletState {}
class AddWalletAdding extends AddWalletState {}
class AddWalletAdded extends AddWalletState {}
