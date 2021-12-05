import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_wallet_event.dart';
part 'add_wallet_state.dart';

class AddWalletBloc extends Bloc<AddWalletEvent, AddWalletState> {
  AddWalletBloc() : super(AddWalletInitial()) {
    on<AddWalletEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
