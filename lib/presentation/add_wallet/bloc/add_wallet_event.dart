part of 'add_wallet_bloc.dart';

abstract class AddWalletEvent extends Equatable {
  const AddWalletEvent();

  @override
  List<Object> get props => [];
}

class AddWalletEventAdd extends AddWalletEvent {
  final String title;
  final String description;
  final List<Remittance> remittances;
  final List<Goal> goals;

  const AddWalletEventAdd(
      {required this.title,
      required this.description,
      required this.remittances,
      required this.goals});
}
