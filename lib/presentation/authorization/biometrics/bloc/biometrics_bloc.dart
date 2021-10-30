import 'package:bloc/bloc.dart';
import 'package:fineance/localization/keys.g.dart';
import 'package:fineance/localization/utils.dart';
import 'package:fineance/repositories/authorization_repository.dart';
import 'package:meta/meta.dart';

part 'biometrics_event.dart';
part 'biometrics_state.dart';

class BiometricsBloc extends Bloc<BiometricsEvent, BiometricsState> {
  final AuthorizationRepository _authorizationRepository;

  BiometricsBloc(this._authorizationRepository) : super(BiometricsInitial()) {
    on<TryToAuth>((event, emit) async {
      final authResult = await _authorizationRepository
          .authenticateUsingBiometrics(translate(LocaleKeys.biometrics_reason));

      if (authResult) {
        emit(AuthSuccess());
      } else {
        emit(AuthError());
      }
    });
  }
}
