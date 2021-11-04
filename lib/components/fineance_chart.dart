import 'package:fineance/style/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

LineChartData fineanceChart({
  required bool isDarkMode,
  required List<String> bottomTexts,
  required List<String> sideTexts,
  required List<FlSpot> earningSpots,
  required List<FlSpot> spendingSpots,
}) {
  return LineChartData(
    gridData: _grid(isDarkMode),
    titlesData: _titles(bottomTexts, sideTexts),
    borderData: _border(isDarkMode),
    minX: 0,
    maxX: 11,
    minY: 0,
    maxY: 6,
    lineBarsData: [_earningLine(earningSpots), _spendingLine(spendingSpots)],
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

FlTitlesData _titles(List<String> bottomTexts, List<String> sideTexts) =>
    FlTitlesData(
      show: true,
      rightTitles: SideTitles(showTitles: false),
      topTitles: SideTitles(showTitles: false),
      bottomTitles: _bottomTexts(bottomTexts),
      leftTitles: _sideTexts(sideTexts),
    );

FlBorderData _border(bool isDarkMode) => FlBorderData(
      show: true,
      border: Border.all(
        color: isDarkMode ? AppColors.grey : AppColors.darkGrey,
        width: 1,
      ),
    );

SideTitles _sideTexts(List<String> texts) => SideTitles(
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
        switch (value.toInt()) {
          case 1:
            return texts[0];
          case 3:
            return texts[1];
          case 5:
            return texts[2];
        }
        return '';
      },
    );

SideTitles _bottomTexts(List<String> texts) => SideTitles(
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
        switch (value.toInt()) {
          case 2:
            return texts[0];
          case 5:
            return texts[1];
          case 8:
            return texts[2];
        }
        return '';
      },
    );

LineChartBarData _earningLine(List<FlSpot> spots) => LineChartBarData(
      spots: spots,
      isCurved: true,
      colors: _earningLineColor,
      barWidth: 5,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
    );

LineChartBarData _spendingLine(List<FlSpot> spots) => LineChartBarData(
      spots: spots,
      isCurved: true,
      colors: _spendingLineColor,
      barWidth: 5,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
    );

List<Color> _earningLineColor = [
  const Color(0xff23b6e6),
  const Color(0xff02d39a),
];

List<Color> _spendingLineColor = [
  Colors.orange,
  AppColors.red,
];
