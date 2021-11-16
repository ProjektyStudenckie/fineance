import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';

class FineanceChartLabel {
  final List<String> titles;
  final List<double> placements;

  const FineanceChartLabel({required this.titles, required this.placements});
}

class FineanceChartSpots {
  final List<List<FlSpot>> spots;
  final List<List<Color>> colors;

  const FineanceChartSpots({required this.spots, required this.colors});
}

class FineanceChartExtent {
  final double minX;
  final double minY;
  final double maxY;
  final double verticalInterval;

  const FineanceChartExtent({
    required this.minX,
    required this.minY,
    required this.maxY,
    required this.verticalInterval,
  });
}

FineanceChartLabel bottomLabels(ChartExtent extent) {
  switch (extent) {
    case ChartExtent.year:
      return FineanceChartLabel(
          titles: _reorderedMonths(extent),
          placements: [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22]);
    case ChartExtent.three_months:
      return FineanceChartLabel(
          titles: _reorderedMonths(extent), placements: [17.5, 19.25, 21.0]);
    case ChartExtent.month:
      return FineanceChartLabel(
          titles: _reorderedMonths(extent), placements: [21.25]);
    default:
      return const FineanceChartLabel(titles: [], placements: []);
  }
}

FineanceChartLabel sideLabels(List<List<FlSpot>> spots) {
  int _lowestY = 0;
  int _highestY = 0;

  for (final list in spots) {
    for (final spot in list) {
      if (spot.y < _lowestY) _lowestY = spot.y.toInt();
      if (spot.y > _highestY) _highestY = spot.y.toInt();
    }
  }

  final List<String> _titles = [
    '$_lowestY',
    '${((_highestY - _lowestY) ~/ 3) + _lowestY}',
    '${((_highestY - _lowestY) * 2 ~/ 3) + _lowestY}',
    '$_highestY',
  ];

  final List<double> _placements = [
    _lowestY.toDouble(),
    (((_highestY - _lowestY) ~/ 3) + _lowestY).toDouble(),
    (((_highestY - _lowestY) * 2 ~/ 3) + _lowestY).toDouble(),
    _highestY.toDouble(),
  ];

  return FineanceChartLabel(titles: _titles, placements: _placements);
}

FineanceChartExtent financeChartExtent({
  required List<List<FlSpot>> spots,
  required ChartExtent xExtent,
}) {
  double _lowestX = 0;
  double _lowestY = 0;
  double _highestY = 0;
  double _vertInt = 0;

  // set X extent
  for (final s in spots) {
    switch (xExtent) {
      case ChartExtent.year:
        _lowestX = _minYearExtent;
        _vertInt = _verticalIntervalYear;
        break;
      case ChartExtent.three_months:
        _lowestX = _minThreeMonthsExtent;
        _vertInt = _verticalIntervalThreeMonths;
        break;
      case ChartExtent.month:
        _lowestX = _minMonthExtent;
        _vertInt = _verticalIntervalMonth;
        break;
    }
  }

  // set Y extent
  for (final list in spots) {
    for (final spot in list) {
      if (spot.y < _lowestY) _lowestY = spot.y;
      if (spot.y > _highestY) _highestY = spot.y;
    }
  }

  final int _additionalMargin = ((_highestY - _lowestY) * 0.2).toInt();

  return FineanceChartExtent(
    minY: _lowestY - _additionalMargin,
    maxY: _highestY + _additionalMargin,
    minX: _lowestX,
    verticalInterval: _vertInt,
  );
}

List<String> _reorderedMonths(ChartExtent extent) {
  final List<String> _oldList = [];
  final List<String> _newList = [];

  for (int i = 0; i < _months.length; i++) {
    if (i <= DateTime.now().month - 1) {
      _oldList.add(_months[i]);
    } else {
      _newList.add(_months[i]);
    }
  }

  final List<String> _finalList = _newList + _oldList;

  switch (extent) {
    case ChartExtent.month:
      return _finalList.sublist(11);
    case ChartExtent.three_months:
      return _finalList.sublist(9);
    default:
      return _finalList;
  }
}

FineanceChartSpots detailedSpots(
    {required FineanceChartSpots spots, required ChartExtent extent}) {
  double _xMinExtent = 0;

  // This has to be adjusted to the way we'll be storing our spots.
  switch (extent) {
    case ChartExtent.month:
      _xMinExtent = _minMonthExtent;
      break;
    case ChartExtent.three_months:
      _xMinExtent = _minThreeMonthsExtent;
      break;
    case ChartExtent.year:
      _xMinExtent = _minYearExtent;
      break;
    default:
      _xMinExtent = 24;
      break;
  }

  final List<List<FlSpot>> _newSpotLists = [];
  for (final list in spots.spots) {
    final List<FlSpot> _newSpots = [];
    for (final spot in list) {
      if (spot.x >= _xMinExtent) {
        _newSpots.add(spot);
      }
    }
    _newSpotLists.add(_newSpots);
  }

  return FineanceChartSpots(spots: _newSpotLists, colors: spots.colors);
}

enum ChartExtent { year, three_months, month }

extension ParseToString on ChartExtent {
  String toNameString() => toString().split('.').last.replaceAll('_', ' ');
}

List<String> _months = [
  'I',
  'II',
  'III',
  'IV',
  'V',
  'VI',
  'VII',
  'VIII',
  'IX',
  'X',
  'XI',
  'XII',
];

// It means that we'll have 4 spots per month, 12 per 3 months etc...
const double _minYearExtent = 0;
const double _minThreeMonthsExtent = 16.5;
const double _minMonthExtent = 20.5;

const double _verticalIntervalYear = 2.0;
const double _verticalIntervalThreeMonths = 0.5;
const double _verticalIntervalMonth = 0.25;
