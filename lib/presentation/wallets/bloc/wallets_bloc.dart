import 'package:bloc/bloc.dart';
import 'package:fineance/repositories/wallets_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'wallets_event.dart';
part 'wallets_state.dart';

class WalletsBloc extends Bloc<WalletsEvent, WalletsState> {
  final WalletRepository walletRepository;

  WalletsBloc(this.walletRepository) : super(WalletsInitial()) {
    on<ChooseNewWallet>((event, emit) {
      walletRepository.setSelectedWallet(event.chosenWallet);
    });
  }
}

// class WalletsBloc extends Bloc<WalletsEvent, WalletsState> {
//   // WalletsBloc() : super(0) {
//   //   on<ChooseNewWallet>((event, emit) => emit(state));
//   // }
//   final WalletRepository walletRepository;
//   // late StreamSubscription _walletChange;
//   //
//   // void listenForChanges() {
//   //   _walletChange = walletRepository.walletIndexStream.listen((data) {
//   //     setCurrentCategory(data);
//   //   });
//   // }
//   //
//   // void setCurrentCategory(int chosenWalletINDEX) {
//   //   //return emit(state.copyWith(productCategory: category));
//   // }
//
//   WalletsBloc(this.walletRepository) : super(WalletsInitial()) {
//     on<ChooseNewWallet>((event, emit) {
//       walletRepository.chosenWalletIndex
//      });
//   }
// }

// class WalletsCubit extends Cubit<WalletsState> {
//   WalletsCubit(this._walletRepository) : super(WalletsInitial()) {
//     _listenForChanges();
//   }
//
//   final WalletRepository _walletRepository;
//   late StreamSubscription _walletChange;
//
//   void _listenForChanges() {
//     _walletChange = _walletRepository.walletIndexStream.listen((data) {
//       _setChosenWallet(data);
//     });
//   }
//
//   void _setChosenWallet(int index) {
//     emit(SelectedWallet(index));
//   }
// }
