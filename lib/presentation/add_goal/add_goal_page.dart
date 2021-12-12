import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fineance/components/fineance_back_button_with_title.dart';
import 'package:fineance/components/fineance_button.dart';
import 'package:fineance/components/fineance_text_field.dart';
import 'package:fineance/injection/bloc_factory.dart';
import 'package:fineance/localization/keys.g.dart';
import 'package:fineance/localization/utils.dart';
import 'package:fineance/presentation/add_goal/bloc/add_goal_bloc.dart';
import 'package:fineance/style/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddGoalPage extends StatefulWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    final BlocFactory blocFactory = BlocFactory.of(context);
    return BlocProvider<AddGoalBloc>(
      create: (context) => blocFactory.get<AddGoalBloc>(),
      child: this,
    );
  }

  @override
  _AddGoalPageState createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
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
    return BlocBuilder<AddGoalBloc, AddGoalState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
              children: [
                _buildTitleTextField(),
                const SizedBox(height: Dimens.kMarginExtraLarge),
                _buildDescriptionTextField(),
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
    return SizedBox(
      width: 500.0,
      height: 80.0,
      child: FineanceBackButtonWithTitle(
          text: translate(LocaleKeys.add_goal_page_add_goal),
          onPressed: () {
            context.router.pop();
          }),
    );
  }

  Widget _buildDescriptionTextField() {
    return FineanceTextField(
      label: translate(LocaleKeys.add_goal_page_title),
      textInputAction: TextInputAction.next,
      controller: _titleController,
    );
  }

  Widget _buildValueTextField() {
    return FineanceTextField(
      label: translate(LocaleKeys.add_goal_page_goal_value),
      textInputAction: TextInputAction.next,
      controller: _valueController,
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
        readOnly: true,
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
    return FineanceButton.positive(
        text: translate(LocaleKeys.add_goal_page_confirm), onPressed: () {});
  }
}
