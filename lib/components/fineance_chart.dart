import 'package:fineance/components/fineance_chart_buttons.dart';
import 'package:fineance/helpers/fineance_chart.dart';
import 'package:fineance/style/colors.dart';
import 'package:fineance/style/dimens.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FineanceChart extends StatefulWidget {
  final FineanceChartSpots spots;
  const FineanceChart({required this.spots});

  @override
  State<FineanceChart> createState() => _FineanceChartState();
}

class _FineanceChartState extends State<FineanceChart> {
  bool showAvg = false;
  ChartExtent chartExtent = ChartExtent.year;

  void setExtent(ChartExtent newExtent) =>
      setState(() => chartExtent = newExtent);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _chartContainer(
          isDarkMode: Theme.of(context).brightness == Brightness.dark,
          spots: detailedSpots(spots: widget.spots, extent: chartExtent),
          sideTexts: sideLabels(
              detailedSpots(spots: widget.spots, extent: chartExtent).spots),
          bottomTexts: bottomLabels(chartExtent),
          chartExtent: financeChartExtent(
              spots:
                  detailedSpots(spots: widget.spots, extent: chartExtent).spots,
              xExtent: chartExtent),
        ),
        FineanceChartButtons(
          setShowAvg: () => setState(() => showAvg = !showAvg),
          showAvg: showAvg,
          extent: chartExtent,
          setNewExtent: (newExtent) => setExtent(newExtent),
        ),
      ],
    );
  }
}

Widget _chartContainer({
  required bool isDarkMode,
  required FineanceChartLabel bottomTexts,
  required FineanceChartLabel sideTexts,
  required FineanceChartSpots spots,
  required FineanceChartExtent chartExtent,
}) =>
    AspectRatio(
      aspectRatio: 1.7,
      child: Container(
        decoration: BoxDecoration(
          border:
              Border.all(color: isDarkMode ? AppColors.grey : AppColors.white),
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          color: isDarkMode ? AppColors.darkGrey : AppColors.grey,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              right: 18.0, left: 10.0, top: 12, bottom: 2.0),
          child: LineChart(
            LineChartData(
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                    maxContentWidth: 100,
                    tooltipBgColor: AppColors.black,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((LineBarSpot touchedSpot) {
                        final textStyle = TextStyle(
                          color: touchedSpot.bar.colors[0],
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        );
                        return LineTooltipItem(
                            touchedSpot.y.toStringAsFixed(2), textStyle);
                      }).toList();
                    }),
                handleBuiltInTouches: true,
                getTouchLineStart: (data, index) => 0,
              ),
              gridData: _grid(chartExtent),
              titlesData:
                  _titles(sideTexts: sideTexts, bottomTexts: bottomTexts),
              borderData: _border(isDarkMode),
              minX: chartExtent.minX,
              maxX: Dimens.kChartXMaxExtent,
              minY: chartExtent.minY,
              maxY: chartExtent.maxY,
              lineBarsData: List.generate(
                  spots.spots.length,
                  (index) => _line(
                      spots: spots.spots[index],
                      lineColor: spots.colors[index])),
            ), // showAvg
          ),
        ),
      ),
    );

FlGridData _grid(FineanceChartExtent extent) => FlGridData(
      show: true,
      drawHorizontalLine: true,
      drawVerticalLine: true,
      horizontalInterval: (extent.maxY - extent.minY) / 4,
      verticalInterval: extent.verticalInterval,
    );

FlTitlesData _titles({
  required FineanceChartLabel bottomTexts,
  required FineanceChartLabel sideTexts,
}) =>
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

SideTitles _sideTexts(FineanceChartLabel texts) => SideTitles(
      showTitles: true,
      interval: 1,
      reservedSize: 32,
      margin: 20,
      getTextStyles: (context, value) => const TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      getTitles: (value) {
        for (int i = 0; i < texts.placements.length; i++) {
          if (value.toInt() == texts.placements[i]) return texts.titles[i];
        }
        return '';
      },
    );

SideTitles _bottomTexts(FineanceChartLabel texts) => SideTitles(
      showTitles: true,
      reservedSize: 22,
      interval: 0.25,
      margin: 8,
      getTextStyles: (context, value) => const TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      getTitles: (value) {
        for (int i = 0; i < texts.placements.length; i++) {
          if (value == texts.placements[i]) return texts.titles[i];
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
