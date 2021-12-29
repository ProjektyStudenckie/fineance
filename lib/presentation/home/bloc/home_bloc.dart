import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fineance/repositories/wallet.dart';
import 'package:fineance/repositories/wallets_repository.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final WalletRepository walletsRepository;
  final Box walletBox;

  HomeBloc(this.walletsRepository, this.walletBox) : super(HomeInitial()) {
  }

  Stream<int> get walletsStream => walletsRepository.chosenWalletIndex.stream;
  StreamController<int> get walletsStreamController => walletsRepository.chosenWalletIndex;
}
