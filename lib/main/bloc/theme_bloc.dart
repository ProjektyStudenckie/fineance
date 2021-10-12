import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(ThemeScheme theme)
      : super(const ThemeLoaded(theme: ThemeScheme.light)) {
    on<ChangeTheme>((event, emit) {
      emit(ThemeLoaded(theme: event.theme));
    });
  }
}

enum ThemeScheme { dark, light }
