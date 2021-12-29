import 'package:bloc/bloc.dart';
import 'package:fineance/repositories/wallets_repository.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'wallets_event.dart';
part 'wallets_state.dart';

class WalletsBloc extends Bloc<WalletsEvent, WalletsState> {
  final WalletRepository walletRepository;
  final Box walletBox;

  WalletsBloc(this.walletRepository, this.walletBox) : super(WalletsInitial()) {
  }
}
