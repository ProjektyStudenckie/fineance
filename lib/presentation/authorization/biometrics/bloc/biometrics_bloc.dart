import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'biometrics_event.dart';
part 'biometrics_state.dart';

class BiometricsBloc extends Bloc<BiometricsEvent, BiometricsState> {
  BiometricsBloc() : super(BiometricsInitial()) {
    on<BiometricsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
