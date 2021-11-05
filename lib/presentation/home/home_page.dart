import 'package:auto_route/auto_route.dart';
import 'package:fineance/components/fineance_chart.dart';
import 'package:fineance/routing/router.gr.dart';
import 'package:fineance/style/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.router.push(const IncomeExpenseRoute());
        },
      ),
      body: Center(child: _chart()),
    );
  }

  Widget _chart() => FineanceChart(
        showAvg: showAvg,
        setShowAvg: () => setState(() => showAvg = !showAvg),
        sideTexts: const ['1k', '3k', '5k'],
        bottomTexts: const ['SEP', 'OCT', 'NOV'],
        spots: [_earningSpots(), _spendingSpots()],
        sideTextsPlacement: const [1, 3, 5],
        bottomTextsPlacement: const [2, 5, 8],
        spotsColors: const [
          AppColors.earningLineColor,
          AppColors.spendingLineColor
        ],
      );

  List<FlSpot> _earningSpots() {
    // mock data
    if (!showAvg) {
      return const [
        FlSpot(0, 3),
        FlSpot(2.6, 2.9),
        FlSpot(4.5, 5),
        FlSpot(6.8, 2.2),
        FlSpot(8, 3),
        FlSpot(9.5, 3.5),
        FlSpot(11, 4),
      ];
    }

    return const [
      FlSpot(0, 3.44),
      FlSpot(2.6, 3.44),
      FlSpot(4.9, 3.44),
      FlSpot(6.8, 3.44),
      FlSpot(8, 3.44),
      FlSpot(9.5, 3.44),
      FlSpot(11, 3.44),
    ];
  }

  List<FlSpot> _spendingSpots() {
    // mock data
    if (!showAvg) {
      return const [
        FlSpot(0, 1),
        FlSpot(3, 0.6),
        FlSpot(5.2, 3),
        FlSpot(7.1, 3.4),
        FlSpot(8.2, 2.9),
        FlSpot(9.9, 2.2),
        FlSpot(11, 1.1),
      ];
    }

    return const [
      FlSpot(0, 2.1),
      FlSpot(2.6, 2.1),
      FlSpot(4.9, 2.1),
      FlSpot(6.8, 2.1),
      FlSpot(8, 2.1),
      FlSpot(9.5, 2.1),
      FlSpot(11, 2.1),
    ];
  }
}
