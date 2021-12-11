import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fineance/repositories/authentication_repository.dart';
import 'package:fineance/repositories/storage_repository.dart';
import 'package:fineance/repositories/user.dart';
import 'package:fineance/repositories/wallet.dart';
import 'package:fineance/repositories/wallets_repository.dart';

part 'add_wallet_event.dart';
part 'add_wallet_state.dart';

class AddWalletBloc extends Bloc<AddWalletEvent, AddWalletState> {
  final WalletRepository walletRepository;
  final StorageService storageService;

  AddWalletBloc(this.walletRepository,this.storageService) : super(AddWalletInitial()) {
    on<AddWalletEvent>((event, emit) async {
      print('KOZAK');
      User user =User(email: '', username: storageService.getUserName(), password: '');
      Wallet wallet = Wallet(description: '', name: '', subowners: [], goal: [], owner: user, value: [], currency: '');
      bool succes = await walletRepository.addWallet(wallet);
      if(succes){
        print('KOZAK');
      }
      else{
        print('Dupa');
      }

    });
  }
}
