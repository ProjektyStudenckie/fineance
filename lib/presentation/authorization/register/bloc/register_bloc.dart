import 'package:bloc/bloc.dart';
import 'package:fineance/injection/modules.dart';
import 'package:fineance/repositories/authentication_repository.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationRepository _authenticationRepository;
  final Box settingsBox;

  RegisterBloc(this._authenticationRepository, this.settingsBox)
      : super(RegisterInitial()) {
    on<RegisterUser>((event, emit) async {
      try {
        emit(RegisterLoading());
        bool response = await _authenticationRepository.register(
            event.email, event.username, event.password);

        if (response) {
          settingsBox.put(IS_ONBOARDING_DONE, true);
          emit(RegisterSuccess());
        } else {
          emit(RegisterError());
        }
      } catch (e) {
        emit(RegisterError());
      }
    });
  }
}
