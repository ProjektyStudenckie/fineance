import 'package:auto_route/auto_route.dart';
import 'package:fineance/components/fineance_chart.dart';
import 'package:fineance/components/fineance_progress_indicator.dart';
import 'package:fineance/extension/context_extension.dart';
import 'package:fineance/helpers/fineance_chart.dart';
import 'package:fineance/localization/keys.g.dart';
import 'package:fineance/localization/utils.dart';
import 'package:fineance/routing/router.gr.dart';
import 'package:fineance/style/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.router.push(const IncomeExpenseRoute());
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FineanceChart(
            spots: FineanceChartSpots(
              spots: [_earningSpots()],
              colors: [AppColors.earningLineColor, AppColors.spendingLineColor],
            ),
          ),
          _buildProgressIndicator(context)
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(BuildContext context) {
    return Column(
      children: [
        Text(
          translate(LocaleKeys.progress_indicator_you_completed),
          style: context.typo.main(
            color: context.isDarkTheme ? AppColors.white : AppColors.black,
          ),
        ),
        const FineanceProgressIndicator(
          completedPercent: 0.989,
          barColor: AppColors.red,
        ),
        Text(
          translate(LocaleKeys.progress_indicator_of_savings_goal),
          style: context.typo.main(
            color: context.isDarkTheme ? AppColors.white : AppColors.black,
          ),
        ),
      ],
    );
  }

  // mock data - each month is 1.5 points long
  List<FlSpot> _earningSpots() {
    return const [
      FlSpot(0, 0),
      FlSpot(2, 20),
      FlSpot(4, 10),
      FlSpot(6, 10),
      FlSpot(8, 60),
      FlSpot(10, 13),
      // half year
      FlSpot(12, 17),
      FlSpot(14, 40),
      FlSpot(14.5, 20),
      FlSpot(15.0, 25),
      FlSpot(16.0, 28),

      // last 3 months
      FlSpot(16.5, 25),
      FlSpot(17.0, 22),
      FlSpot(17.5, 18),
      FlSpot(18, 20),
      // last 2 months
      FlSpot(18.5, 18),
      FlSpot(19.0, 22),
      FlSpot(19.5, 26),
      FlSpot(20.0, 25),

      // last month
      FlSpot(20.5, 6),
      FlSpot(21, 15),
      FlSpot(21.5, 12),
      FlSpot(22, 10),
    ];
  }
}
