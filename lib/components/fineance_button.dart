import 'package:fineance/style/colors.dart';
import 'package:fineance/style/constants.dart';
import 'package:fineance/style/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FineanceButton extends StatelessWidget {
  const FineanceButton({
    required this.label,
    this.color = AppColors.blue,
    required this.function,
    Key? key,
  }) : super(key: key);

  final Color color;
  final String label;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: function,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(color),
        fixedSize: MaterialStateProperty.all<Size>(const Size(
            Constants.kNormalWidgetWidth, Constants.kNormalWidgetHeight)),
      ),
      child: Text(
        label,
        style: AppTypography().mainBold().copyWith(
              color: AppColors.white,
            ),
      ),
    );
  }
}
