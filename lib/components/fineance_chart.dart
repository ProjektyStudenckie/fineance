import 'package:fineance/style/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FineanceChart extends StatefulWidget {
  const FineanceChart({
    required this.showAvg,
    required this.setShowAvg,
    required this.bottomTexts,
    required this.bottomTextsPlacement,
    required this.sideTexts,
    required this.sideTextsPlacement,
    required this.spots,
    required this.spotsColors,
  });
  final bool showAvg;
  final VoidCallback setShowAvg;
  final List<String> bottomTexts;
  final List<int> bottomTextsPlacement;
  final List<String> sideTexts;
  final List<int> sideTextsPlacement;
  final List<List<FlSpot>> spots;
  final List<List<Color>> spotsColors;

  @override
  State<FineanceChart> createState() => _FineanceChartState();
}

class _FineanceChartState extends State<FineanceChart> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _chartContainer(
          sideTextsPlacement: widget.sideTextsPlacement,
          bottomTextsPlacement: widget.bottomTextsPlacement,
          spotsColors: widget.spotsColors,
          isDarkMode: Theme.of(context).brightness == Brightness.dark,
          spots: widget.spots,
          sideTexts: widget.sideTexts,
          bottomTexts: widget.bottomTexts,
        ),
        _avgButton(
          setShowAvg: () => widget.setShowAvg(),
          showAvg: widget.showAvg,
        ),
      ],
    );
  }
}

Widget _chartContainer({
  required bool isDarkMode,
  required List<String> bottomTexts,
  required List<int> bottomTextsPlacement,
  required List<String> sideTexts,
  required List<int> sideTextsPlacement,
  required List<List<FlSpot>> spots,
  required List<List<Color>> spotsColors,
}) =>
    SizedBox(
      width: 350.0,
      height: 220.0,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isDarkMode ? AppColors.grey : AppColors.white,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(18),
          ),
          color: isDarkMode ? AppColors.darkGrey : AppColors.grey,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              right: 18.0, left: 12.0, top: 24, bottom: 12),
          child: LineChart(
            _chart(
              isDarkMode: isDarkMode,
              sideTexts: sideTexts,
              bottomTexts: bottomTexts,
              spots: spots,
              spotsColors: spotsColors,
              sideTextsPlacement: sideTextsPlacement,
              bottomTextsPlacement: bottomTextsPlacement,
            ), // showAvg
          ),
        ),
      ),
    );

LineChartData _chart({
  required bool isDarkMode,
  required List<String> bottomTexts,
  required List<int> bottomTextsPlacement,
  required List<String> sideTexts,
  required List<int> sideTextsPlacement,
  required List<List<FlSpot>> spots,
  required List<List<Color>> spotsColors,
}) {
  return LineChartData(
    gridData: _grid(isDarkMode),
    titlesData: _titles(
      sideTexts: sideTexts,
      bottomTexts: bottomTexts,
      sideTextPlacement: sideTextsPlacement,
      bottomTextsPlacement: bottomTextsPlacement,
    ),
    borderData: _border(isDarkMode),
    minX: 0,
    maxX: 11,
    minY: 0,
    maxY: 6,
    lineBarsData: List.generate(spots.length,
        (index) => _line(spots: spots[index], lineColor: spotsColors[index])),
  );
}

FlGridData _grid(bool isDarkMode) => FlGridData(
      show: true,
      drawVerticalLine: true,
      getDrawingHorizontalLine: (value) => FlLine(
        color: isDarkMode ? AppColors.grey : const Color(0xff37434d),
        strokeWidth: 1,
      ),
      getDrawingVerticalLine: (value) => FlLine(
        color: isDarkMode ? AppColors.grey : const Color(0xff37434d),
        strokeWidth: 1,
      ),
    );

FlTitlesData _titles({
  required List<String> bottomTexts,
  required List<String> sideTexts,
  required List<int> sideTextPlacement,
  required List<int> bottomTextsPlacement,
}) =>
    FlTitlesData(
      show: true,
      rightTitles: SideTitles(showTitles: false),
      topTitles: SideTitles(showTitles: false),
      bottomTitles: _bottomTexts(bottomTexts, bottomTextsPlacement),
      leftTitles: _sideTexts(sideTexts, sideTextPlacement),
    );

FlBorderData _border(bool isDarkMode) => FlBorderData(
      show: true,
      border: Border.all(
        color: isDarkMode ? AppColors.grey : AppColors.darkGrey,
        width: 1,
      ),
    );

SideTitles _sideTexts(List<String> texts, List<int> placement) => SideTitles(
      showTitles: true,
      interval: 1,
      reservedSize: 32,
      margin: 12,
      getTextStyles: (context, value) => const TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
      getTitles: (value) {
        for (int i = 0; i < placement.length; i++) {
          if (value.toInt() == placement[i]) return texts[i];
        }
        return '';
      },
    );

SideTitles _bottomTexts(List<String> texts, List<int> placement) => SideTitles(
      showTitles: true,
      reservedSize: 22,
      interval: 1,
      margin: 8,
      getTextStyles: (context, value) => const TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      getTitles: (value) {
        for (int i = 0; i < placement.length; i++) {
          if (value.toInt() == placement[i]) return texts[i];
        }
        return '';
      },
    );

LineChartBarData _line(
        {required List<FlSpot> spots, required List<Color> lineColor}) =>
    LineChartBarData(
      spots: spots,
      isCurved: true,
      colors: lineColor,
      barWidth: 5,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
    );

Widget _avgButton({required VoidCallback setShowAvg, required bool showAvg}) =>
    SizedBox(
      width: 60,
      height: 34,
      child: TextButton(
        onPressed: () => setShowAvg(),
        child: Text(
          'Avg',
          style: TextStyle(
            fontSize: 12,
            color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
          ),
        ),
      ),
    );
