import 'package:auto_route/auto_route.dart';
import 'package:fineance/injection/bloc_factory.dart';
import 'package:fineance/presentation/income_expense/bloc/income_expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncomeExpensePage extends StatefulWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    final BlocFactory blocFactory = BlocFactory.of(context);
    return BlocProvider<IncomeExpenseBloc>(
      create: (context) => blocFactory.get<IncomeExpenseBloc>(),
      child: this,
    );
  }

  @override
  _IncomeExpensePageState createState() => _IncomeExpensePageState();
}

class _IncomeExpensePageState extends State<IncomeExpensePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IncomeExpenseBloc, IncomeExpenseState>(
      listener: (context, state) {},
      builder: (context, state) {
        return const Scaffold(
          body: Center(
            child: Text("income / expense page"),
          ),
        );
      },
    );
  }
}
