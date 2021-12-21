import 'package:bloc/bloc.dart';
import 'package:fineance/injection/modules.dart';
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
    Init();

    on<GetNewWallet>((event, emit) async {
      await Init();
    });
  }

  Init() async{
    final int _chosenWallet =
    walletBox.get(CHOSEN_WALLET_INDEX, defaultValue: 0) as int;
    await walletsRepository.downloadWallets();
    Wallet wallet =walletsRepository.wallets[_chosenWallet];
    emit(ChosenWallet(wallet: wallet));
  }

}
