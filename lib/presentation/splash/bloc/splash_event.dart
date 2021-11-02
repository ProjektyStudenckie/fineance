part of 'splash_bloc.dart';

@immutable
abstract class SplashEvent {}

class LoadApp extends SplashEvent {
  final FineanceQuickActions? quickAction;

  LoadApp([this.quickAction]);
}
