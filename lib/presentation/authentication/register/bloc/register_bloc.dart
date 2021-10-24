import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

// class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
//   final AuthorizationRepository _authorizationRepository;
//   final Box settingsBox;
//
//   RegisterBloc(this._authorizationRepository, this.settingsBox)
//       : super(RegisterInitial()) {
//     on<RegisterUser>((event, emit) async {
//       try {
//         emit(RegisterLoading());
//         await _authorizationRepository.register(
//             event.email, event.username, event.password);
//         settingsBox.put(ONBOARDING_DONE, true);
//
//         emit(RegisterSuccess());
//       } catch (e) {
//         emit(RegisterError());
//       }
//     });
//   }
// }
