import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fineance/components/fineance_back_button_with_title.dart';
import 'package:fineance/components/fineance_button.dart';
import 'package:fineance/components/fineance_text_field.dart';
import 'package:fineance/components/fineance_values_switch.dart';
import 'package:fineance/injection/bloc_factory.dart';
import 'package:fineance/localization/keys.g.dart';
import 'package:fineance/localization/utils.dart';
import 'package:fineance/presentation/income_expense/bloc/income_expense_bloc.dart';
import 'package:fineance/style/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime _date = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IncomeExpenseBloc, IncomeExpenseState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
              children: [
                FineanceBackButtonWithTitle(
                    text: translate(LocaleKeys.income_expense_register_value),
                    onPressed: () {
                      context.router.pop();
                    }),
                const SizedBox(height: Dimens.kMarginLargeDouble),
                FineanceValuesSwitch(
                  firstText: translate(LocaleKeys.income_expense_income),
                  secondText: translate(LocaleKeys.income_expense_expense),
                  onChange: (tabIndex) {},
                ),
                const SizedBox(height: Dimens.kMarginExtraLarge),
                _buildTitleTextField(),
                _buildValueTextField(),
                _buildDatePicker(),
                _buildConfirmButton(),
              ],
            )),
          ),
        );
      },
    );
  }

  Widget _buildTitleTextField() {
    return FineanceTextField(
      label: translate(LocaleKeys.income_expense_title),
      textInputAction: TextInputAction.next,
      controller: _titleController,
    );
  }

  Widget _buildValueTextField() {
    return FineanceTextField(
      label: translate(LocaleKeys.income_expense_value),
      textInputAction: TextInputAction.next,
      controller: _valueController,
      textInputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r"^\d+\.?\d{0,2}"))
      ],
    );
  }

  Widget _buildDatePicker() {
    const twentyYearsInDays = 7300;
    final DateFormat formatter = DateFormat.yMMMMd();
    final String formatted = formatter.format(_date);
    _dateController.value = TextEditingValue(text: formatted);

    return FineanceTextField(
        label: translate(LocaleKeys.income_expense_date),
        controller: _dateController,
        onTap: () async {
          final pickedDate = await showDatePicker(
            context: context,
            initialDate: _date,
            firstDate: _date.subtract(const Duration(days: twentyYearsInDays)),
            lastDate: _date.add(const Duration(days: twentyYearsInDays)),
          );

          if (pickedDate != null && pickedDate != _date) {
            setState(() {
              _date = pickedDate;
            });
          }
        });
  }

  Widget _buildConfirmButton() {
    return FineanceButton.positive(text: "Confirm", onPressed: () {});
  }
}
