import 'package:bloc/bloc.dart';
import 'package:fineance/repositories/authorization_repository.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthorizationRepository _authorizationRepository;
  final Box settingsBox;

  LoginBloc(this._authorizationRepository, this.settingsBox) : super(LoginInitial()) {
    on<LoginUser>((event, emit) async {
      try {
        emit(LoginLoading());
        await _authorizationRepository.login(event.username, event.password);
        
        emit(LoginSuccess(shouldShowOnboarding: true));
      } catch (e) {
        emit(LoginError());
      }
    });
  }
}
