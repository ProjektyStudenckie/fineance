import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_goal_event.dart';
part 'add_goal_state.dart';

class AddGoalBloc extends Bloc<AddGoalEvent, AddGoalState> {
  AddGoalBloc() : super(AddGoalInitial()) {
    on<AddGoalEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
