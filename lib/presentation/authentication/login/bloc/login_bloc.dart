import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fineance/injection/modules.dart';
import 'package:fineance/repositories/authentication_repository.dart';
import 'package:fineance/repositories/models/password.dart';
import 'package:fineance/repositories/models/user_name.dart';
import 'package:formz/formz.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;
  final Box _settingsBox;

  LoginBloc({
    required AuthenticationRepository authenticationRepository,
    required Box settingsBox,
  })  : _authenticationRepository = authenticationRepository,
        _settingsBox = settingsBox,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  // LoginBloc(this._authenticationRepository, this._settingsBox)
  //     : super(LoginInitial()) {
  //   on<LoginUser>((event, emit) async {
  //     try {
  //       emit(LoginLoading());
  //
  //       await _authenticationRepository.login(event.username, event.password);
  //
  //       final shouldShowOnboarding = _settingsBox.get(ONBOARDING_DONE) != true;
  //       if (shouldShowOnboarding) {
  //         _settingsBox.put(ONBOARDING_DONE, true);
  //       }
  //
  //       emit(LoginSuccess(shouldShowOnboarding: shouldShowOnboarding));
  //     } catch (e) {
  //       emit(LoginError());
  //     }
  //   });
  // }

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    ));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    ));
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _authenticationRepository.logIn(
          username: state.username.value,
          password: state.password.value,
        );
        final shouldShowOnboarding = _settingsBox.get(ONBOARDING_DONE) != true;
        if (shouldShowOnboarding) {
          _settingsBox.put(ONBOARDING_DONE, true);
        }
        emit(LoginSuccess(shouldShowOnboarding: shouldShowOnboarding));
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
