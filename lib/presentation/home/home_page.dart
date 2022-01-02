import 'package:auto_route/auto_route.dart';
import 'package:fineance/components/fineance_button.dart';
import 'package:fineance/components/fineance_chart.dart';
import 'package:fineance/components/fineance_info_tab.dart';
import 'package:fineance/components/fineance_progress_indicator.dart';
import 'package:fineance/extension/context_extension.dart';
import 'package:fineance/helpers/fineance_chart.dart';
import 'package:fineance/injection/bloc_factory.dart';
import 'package:fineance/localization/keys.g.dart';
import 'package:fineance/localization/utils.dart';
import 'package:fineance/presentation/home/bloc/home_bloc.dart';
import 'package:fineance/repositories/goal.dart';
import 'package:fineance/repositories/wallet.dart';
import 'package:fineance/routing/router.gr.dart';
import 'package:fineance/style/colors.dart';
import 'package:fineance/style/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget implements AutoRouteWrapper {
  late Wallet wallet;

  @override
  Widget wrappedRoute(BuildContext context) {
    final BlocFactory blocFactory = BlocFactory.of(context);
    return BlocProvider<HomeCubit>(
      create: (context) => blocFactory.get<HomeCubit>(),
      child: this,
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is ChosenWallet) {
          widget.wallet = state.wallet;
          return Scaffold(
              appBar: _buildAppBar(),
              body: SafeArea(child: FutureBuilder(
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 450.0,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildChart(),
                              const SizedBox(height: 30.0),
                              _buildProgressIndicator(),
                              const SizedBox(height: 30.0),
                              _buildIncomeExpenseInfoTabs(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      _buildIncomeExpenseButton(),
                      _buildAddGoalButton(),
                    ],
                  );
                },
              )));
        }

        return const Scaffold(
            body: Center(child: Text('Please choose a wallet.')));
      },
    );
  }

  AppBar _buildAppBar() => AppBar(
        backgroundColor:
            context.isDarkTheme ? AppColors.darkGrey : AppColors.white,
        elevation: 0.0,
        leading: _buildAppBarLeading(),
        automaticallyImplyLeading: false,
        leadingWidth: 500.0,
        toolbarHeight: 100.0,
      );

  Widget _buildAppBarLeading() => Padding(
        padding: const EdgeInsets.only(
          top: Dimens.kMarginLargeDouble,
          left: Dimens.kMarginLargeDouble,
        ),
        child: Text(
          widget.wallet.name,
          style: context.typo.extraLargeBold(
              color: context.isDarkTheme ? AppColors.white : AppColors.black),
        ),
      );

  Widget _buildChart() => FineanceChart(
          spots: FineanceChartSpots(spots:
          [widget.wallet.calculatePointToDisplay(true),
        widget.wallet.calculatePointToDisplay(false),
      ], colors: [
        AppColors.earningLineColor,
        AppColors.spendingLineColor
      ]));

  Widget _buildProgressIndicator() {
    if (widget.wallet != null && widget.wallet.nextGoal().value != 0) {
      return Column(
        children: [
          Text(
            'You have completed',
            style: context.typo.mainBold().copyWith(
                  color: context.isDarkTheme ? Colors.white : Colors.black,
                ),
          ),
          FineanceProgressIndicator(
              barColor: AppColors.red,
              completedPercent:
                  widget.wallet.wholeValue / widget.wallet.nextGoal().value),
          Text(
            'of your next goal.',
            style: context.typo.mainBold().copyWith(
                  color: context.isDarkTheme ? Colors.white : Colors.black,
                ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Text(
            'You Have Completed All Goals',
            style: context.typo.mainBold().copyWith(
                  color: context.isDarkTheme ? Colors.white : Colors.black,
                ),
          ),
        ],
      );
    }
  }

  Widget _buildIncomeExpenseButton() {
    return FineanceButton(
        text: translate(LocaleKeys.add_wallet_page_add_income_expense),
        onPressed: () async {
          final _newRemittance =
              await context.router.push(const IncomeExpenseRoute());
          BlocProvider.of<HomeCubit>(context)
              .addRemittance(widget.wallet, _newRemittance as Remittance);
        });
  }

  Widget _buildAddGoalButton() {
    return FineanceButton(
        // TODO change text to locale
        text: 'Add goal',
        onPressed: () async {
          final _newGoal = await context.router.push(const AddGoalRoute());
          BlocProvider.of<HomeCubit>(context)
              .addGoal(widget.wallet, _newGoal as Goal);
        });
  }

  Widget _buildIncomeExpenseInfoTabs() {
    return Column(
      children: List.generate(
          widget.wallet.value.length,
          (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: FineanceInfoTab(remittance: widget.wallet.value[index]),
              )),
    );
  }
}
