import 'package:bloc/bloc.dart';
import 'package:fineance/repositories/wallets_repository.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final WalletRepository walletsRepository;
  final Box walletBox;

  HomeBloc(this.walletsRepository, this.walletBox) : super(HomeInitial()) {
    // walletsRepository.chosenWalletIndex.stream.listen((value) {
    //   print(value);
    //   add(GetNewWallet(val: value));
    //   //emit(ChosenWallet(chosenWallet: value));
    // });
    // on<GetNewWallet>((event, emit) {
    //   emit(ChosenWallet(chosenWallet: event.val));
    //   // final int _chosenWallet =
    //   //     int.parse(walletBox.get(CHOSEN_WALLET_INDEX).toString());
    // });
  }

  Stream<int> get walletsStream => walletsRepository.chosenWalletIndex.stream;
}
