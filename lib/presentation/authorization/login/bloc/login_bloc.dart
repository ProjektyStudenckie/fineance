import 'package:bloc/bloc.dart';
import 'package:fineance/injection/modules.dart';
import 'package:fineance/repositories/authorization_repository.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthorizationRepository _authorizationRepository;
  final Box _settingsBox;

  LoginBloc(this._authorizationRepository, this._settingsBox)
      : super(LoginInitial()) {
    on<LoginUser>((event, emit) async {
      try {
        emit(LoginLoading());

        await _authorizationRepository.login(event.username, event.password);

        final shouldShowOnboarding = _settingsBox.get(ONBOARDING_DONE) != true;
        if (shouldShowOnboarding) {
          _settingsBox.put(ONBOARDING_DONE, true);
        }

        emit(LoginSuccess(shouldShowOnboarding: shouldShowOnboarding));
      } catch (e) {
        emit(LoginError());
      }
    });
  }
}
