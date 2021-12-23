import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fineance/components/fineance_back_button_with_title.dart';
import 'package:fineance/components/fineance_button.dart';
import 'package:fineance/components/fineance_loader.dart';
import 'package:fineance/components/fineance_text_field.dart';
import 'package:fineance/injection/bloc_factory.dart';
import 'package:fineance/localization/keys.g.dart';
import 'package:fineance/localization/utils.dart';
import 'package:fineance/presentation/add_wallet/bloc/add_wallet_bloc.dart';
import 'package:fineance/repositories/goal.dart';
import 'package:fineance/repositories/wallet.dart';
import 'package:fineance/routing/router.gr.dart';
import 'package:fineance/style/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddWalletPage extends StatefulWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    final BlocFactory blocFactory = BlocFactory.of(context);
    return BlocProvider<AddWalletBloc>(
      create: (context) => blocFactory.get<AddWalletBloc>(),
      child: this,
    );
  }

  @override
  _AddWalletPageState createState() => _AddWalletPageState();
}

class _AddWalletPageState extends State<AddWalletPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime _date = DateTime.now();

  final List<Remittance> _remittances = [];
  final List<Goal> _goals = [];

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddWalletBloc, AddWalletState>(
      builder: (context, state) {
        if (state is AddWalletAdded){
        context.popRoute();
        return const Scaffold(body: Center(child: FineanceLoader()));
        }
        else if(state is AddWalletAdding){
          return const Scaffold(body: Center(child: FineanceLoader()));
        }
        else{
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
              children: [
                _buildPageTitleTextField(),
                const SizedBox(height: Dimens.kMarginExtraLarge),
                _buildTitleTextField(),
                _buildDescriptionTextField(),
                _buildIcomeExpenseButton(),
                _buildAddGoalButton(),
                _buildDatePicker(),
                const SizedBox(height: Dimens.kMarginExtraLarge),
                _buildConfirmButton(),
              ],
            )),
          ),
        );}
      },
    );
  }

  Widget _buildPageTitleTextField() {
    return SizedBox(
      width: 500.0,
      height: 80.0,
      child: FineanceBackButtonWithTitle(
          text: translate(LocaleKeys.add_wallet_page_add_wallet),
          onPressed: () {
            context.router.pop();
          }),
    );
  }

  Widget _buildTitleTextField() {
    return FineanceTextField(
      label: translate(LocaleKeys.income_expense_title),
      textInputAction: TextInputAction.next,
      controller: _titleController,
    );
  }

  Widget _buildDescriptionTextField() {
    return FineanceTextField(
      label: translate(LocaleKeys.add_wallet_page_description),
      textInputAction: TextInputAction.next,
      controller: _descriptionController,
    );
  }

  Widget _buildIcomeExpenseButton() {
    return FineanceButton(
        text: translate(LocaleKeys.add_wallet_page_add_income_expense),
        onPressed: () async {
          final _newRemittance =
              await context.router.push(const IncomeExpenseRoute());
          _remittances.add(_newRemittance as Remittance);
        });
  }

  Widget _buildAddGoalButton() {
    return FineanceButton(
        // TODO change text to locale
        text: 'Add goal',
        onPressed: () async {
          final _newGoal = await context.router.push(const AddGoalRoute());
          _goals.add(_newGoal as Goal);
        });
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
        text: translate(LocaleKeys.add_wallet_page_confirm),
        onPressed: () {
          BlocProvider.of<AddWalletBloc>(context).add(
            AddWalletEventAdd(
                remittances: _remittances,
                goals: _goals,
                description: _descriptionController.value.text,
                title: _titleController.value.text),
          );
        });
  }
}
