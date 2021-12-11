import 'package:bloc/bloc.dart';
import 'package:fineance/repositories/wallets_repository.dart';
import 'package:meta/meta.dart';

part 'wallets_event.dart';
part 'wallets_state.dart';

class WalletsBloc extends Bloc<WalletsEvent, WalletsState> {
  final WalletRepository walletRepository;
  WalletsBloc(this.walletRepository) : super(WalletsInitial()) {
    on<WalletsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
