part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class ChangeGlobalTheme extends ThemeEvent {
  final ThemeScheme theme;

  ChangeGlobalTheme({required this.theme});
}
