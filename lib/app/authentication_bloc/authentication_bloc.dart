import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fineance/repositories/authentication_repository.dart';
import 'package:fineance/repositories/models/user.dart';
import 'package:fineance/repositories/user_repository.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final AuthorizationRepository _authorizationRepository;
//   final Box _settingsBox;
//
//   LoginBloc(this._authorizationRepository, this._settingsBox)
//       : super(LoginInitial()) {
//     on<LoginUser>((event, emit) async {
//       try {
//         emit(LoginLoading());
//
//         await _authorizationRepository.login(event.username, event.password);
//
//         final shouldShowOnboarding = _settingsBox.get(ONBOARDING_DONE) != true;
//         if (shouldShowOnboarding) {
//           _settingsBox.put(ONBOARDING_DONE, true);
//         }
//
//         emit(LoginSuccess(shouldShowOnboarding: shouldShowOnboarding));
//       } catch (e) {
//         emit(LoginError());
//       }
//     });
//   }
// }

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  void _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        return emit(user != null
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.unauthenticated());
      default:
        return emit(const AuthenticationState.unknown());
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepository.logOut();
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }
}
