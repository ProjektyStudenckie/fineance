part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetNewWallet extends HomeEvent {
  final int val;
  GetNewWallet({required this.val});
}
