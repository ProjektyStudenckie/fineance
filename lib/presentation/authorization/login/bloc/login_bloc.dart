import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fineance/injection/modules.dart';
import 'package:fineance/repositories/authentication_repository.dart';
import 'package:fineance/repositories/storage_repository.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;
  final Box _settingsBox;
  final StorageService _storageService;

  LoginBloc(
      this._authenticationRepository, this._settingsBox, this._storageService)
      : super(LoginInitial()) {
    on<TryLoginOnStart>((event, emit) async {
      final username = _storageService.getUserName();
      if (username != "") {
        final value = await _authenticationRepository.refreshToken();

        if (value) {
          final bool shouldShowOnboarding =
              _settingsBox.get(IS_ONBOARDING_DONE) != true;
          if (shouldShowOnboarding) {
            _settingsBox.put(IS_ONBOARDING_DONE, true);
          }

          emit(LoginSuccess(shouldShowOnboarding: shouldShowOnboarding));
        } else {
          emit(LoginIncorrect());
        }
      }else{
        emit(LoginIncorrect());
      }
    });

    on<LoginUser>((event, emit) async {
      try {
        emit(LoginLoading());

        final authenticated = await _authenticationRepository.login(
            event.username, event.password);

        if (!authenticated) {
          emit(LoginIncorrect());
        } else {
          final shouldShowOnboarding =
              _settingsBox.get(IS_ONBOARDING_DONE) != true;
          if (shouldShowOnboarding) {
            _settingsBox.put(IS_ONBOARDING_DONE, true);
          }

          emit(LoginSuccess(shouldShowOnboarding: shouldShowOnboarding));
        }
      } catch (e) {
        emit(LoginError());
      }
    });
  }
}
