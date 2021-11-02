import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'income_expense_event.dart';
part 'income_expense_state.dart';

class IncomeExpenseBloc extends Bloc<IncomeExpenseEvent, IncomeExpenseState> {
  IncomeExpenseBloc() : super(IncomeExpenseInitial()) {
    on<IncomeExpenseEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
