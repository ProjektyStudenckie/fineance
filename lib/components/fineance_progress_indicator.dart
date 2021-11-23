import 'package:fineance/extension/context_extension.dart';
import 'package:fineance/style/colors.dart';
import 'package:fineance/style/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class FineanceProgressIndicator extends StatelessWidget {
  final double completedPercent;
  final Color barColor;
  const FineanceProgressIndicator({
    Key? key,
    required this.barColor,
    required this.completedPercent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.kMarginLarge),
      child: LinearPercentIndicator(
        backgroundColor: AppColors.lightGrey,
        animation: true,
        lineHeight: 28.0,
        animationDuration: 1000,
        curve: Curves.easeInOut,
        percent: completedPercent,
        center: Text('${(completedPercent * 100).floor()}%',
            style: context.typo.mainMediumBold()),
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: barColor,
      ),
    );
  }
}
