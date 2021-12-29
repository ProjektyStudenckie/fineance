import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fineance/repositories/goal.dart';
import 'package:fineance/repositories/storage_repository.dart';
import 'package:fineance/repositories/user.dart';
import 'package:fineance/repositories/wallet.dart';
import 'package:fineance/repositories/wallets_repository.dart';

part 'add_wallet_event.dart';
part 'add_wallet_state.dart';

class AddWalletBloc extends Bloc<AddWalletEvent, AddWalletState> {
  final WalletRepository walletRepository;
  final StorageService storageService;

  AddWalletBloc(this.walletRepository, this.storageService)
      : super(AddWalletInitial()) {
    on<AddWalletEventAdd>((event, emit) async {
      emit(AddWalletAdding());
      final User _user =
          User(email: '', username: storageService.getUserName(), password: '');
      final Wallet _wallet = Wallet(
          description: event.description,
          name: event.title,
          subowners: [],
          goal: event.goals,
          owner: _user,
          value: event.remittances,
          currency: '');
      final bool _success = await walletRepository.addWallet(_wallet);
      if (_success) {
        print('KOZAK');
      } else {
        print('Dupa');
        await walletRepository.addWallet(_wallet);
      }
      await walletRepository.downloadWallets();
      emit(AddWalletAdded());
    });
  }
}
