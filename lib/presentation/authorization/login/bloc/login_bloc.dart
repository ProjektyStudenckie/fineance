import 'package:bloc/bloc.dart';
import 'package:fineance/injection/modules.dart';
import 'package:fineance/repositories/authentication_repository.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;
  final Box _settingsBox;

  LoginBloc(this._authenticationRepository, this._settingsBox)
      : super(LoginInitial()) {
    on<LoginUser>((event, emit) async {
      try {
        emit(LoginLoading());

        await _authenticationRepository.login(event.username, event.password);

        final shouldShowOnboarding = _settingsBox.get(IS_ONBOARDING_DONE) != true;
        if (shouldShowOnboarding) {
          _settingsBox.put(IS_ONBOARDING_DONE, true);
        }

        emit(LoginSuccess(shouldShowOnboarding: shouldShowOnboarding));
      } catch (e) {
        emit(LoginError());
      }
    });
  }
}
