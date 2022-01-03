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
  late int indexWallet;

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
    indexWallet = index;
    emit(ChosenWallet(wallet: _wallet));
  }

  void addGoal(Wallet wallet, Goal goal) async {
    print(goal);
    await _walletsRepository.addGoal(wallet, goal);
    await _walletsRepository.downloadWallets();
    final Wallet _wallet = _walletsRepository.wallets[indexWallet];
    emit(ChosenWallet(wallet: _wallet));
  }

  void addRemittance(Wallet wallet, Remittance remittance) async {
    await _walletsRepository.addRemitance(wallet, remittance);
    await _walletsRepository.downloadWallets();
    final Wallet _wallet = _walletsRepository.wallets[indexWallet];
    emit(ChosenWallet(wallet: _wallet));
  }

  void deleteGoal(Wallet wallet, Goal goal) async {
    print('ewg');
    await _walletsRepository.removeGoal(wallet, goal);
    await _walletsRepository.downloadWallets();
    final Wallet _wallet = _walletsRepository.wallets[indexWallet];
    emit(ChosenWallet(wallet: _wallet));
  }

  @override
  Future<void> close() {
    _walletChange.cancel();
    return super.close();
  }
}
