part of 'add_goal_bloc.dart';

abstract class AddGoalState extends Equatable {
  const AddGoalState();

  @override
  List<Object> get props => [];
}

class AddGoalInitial extends AddGoalState {}
