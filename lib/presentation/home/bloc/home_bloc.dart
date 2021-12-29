import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fineance/repositories/goal.dart';
import 'package:fineance/repositories/wallet.dart';
import 'package:fineance/repositories/wallets_repository.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final WalletRepository _walletsRepository;
  late StreamSubscription _walletChange;

  HomeCubit(this._walletsRepository) : super(HomeInitial()) {
    _listenForChanges();
  }

  void _listenForChanges() {
    _walletChange = _walletsRepository.walletIndexStream.listen((data) {
      _setChosenWallet(data);
    });
  }

  void _setChosenWallet(int index) async {
    await _walletsRepository.downloadWallets();
    final Wallet _wallet = _walletsRepository.wallets[index];
    emit(ChosenWallet(wallet: _wallet));
  }

  void addGoal(Wallet wallet, Goal goal) {
    _walletsRepository.addGoal(wallet, goal);
  }

  void addRemittance(Wallet wallet, Remittance remittance) {
    _walletsRepository.addRemitance(wallet, remittance);
  }

  @override
  Future<void> close() {
    _walletChange.cancel();
    return super.close();
  }
}
