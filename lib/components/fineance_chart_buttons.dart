import 'package:fineance/helpers/fineance_chart.dart';
import 'package:fineance/localization/keys.g.dart';
import 'package:fineance/localization/utils.dart';
import 'package:fineance/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FineanceChartButtons extends StatelessWidget {
  final VoidCallback setShowAvg;
  final bool showAvg;
  final Function(ChartExtent) setNewExtent;
  final ChartExtent extent;

  const FineanceChartButtons({
    required this.setShowAvg,
    required this.showAvg,
    required this.setNewExtent,
    required this.extent,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _avgButton(
              isDarkMode: Theme.of(context).brightness == Brightness.dark),
          _dropDownButton(
              isDarkMode: Theme.of(context).brightness == Brightness.dark),
        ],
      ),
    );
  }

  Widget _avgButton({required bool isDarkMode}) => TextButton(
        onPressed: () => setShowAvg(),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: const BorderSide(color: AppColors.darkGrey))),
          backgroundColor: MaterialStateProperty.all<Color>(
              isDarkMode ? AppColors.darkGrey : AppColors.white),
        ),
        child: Text(
          translate(LocaleKeys.chart_avg),
          style: TextStyle(
            fontSize: 12,
            color: isDarkMode
                ? (showAvg ? Colors.white.withOpacity(0.5) : Colors.white)
                : (showAvg ? AppColors.lightGrey : Colors.black),
          ),
        ),
      );

  Widget _dropDownButton({required bool isDarkMode}) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(
              color: isDarkMode ? AppColors.grey : AppColors.darkGrey),
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          color: isDarkMode ? AppColors.darkGrey : AppColors.white,
        ),
        child: DropdownButton<ChartExtent>(
          value: extent,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 42,
          onChanged: (ex) => setNewExtent(ex!),
          items: ChartExtent.values
              .map(
                (extent) => DropdownMenuItem<ChartExtent>(
                  value: extent,
                  child: Text(extent.toNameString()),
                ),
              )
              .toList(),
        ),
      );
}
