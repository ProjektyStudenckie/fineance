part of 'theme_bloc.dart';

@immutable
abstract class ThemeState {
  final ThemeScheme theme;

  const ThemeState({required this.theme});
}

class ThemeLoaded extends ThemeState {
  const ThemeLoaded({required ThemeScheme theme}) : super(theme: theme);
}
