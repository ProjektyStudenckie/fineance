import 'package:fineance/extension/context_extension.dart';
import 'package:fineance/style/colors.dart';
import 'package:fineance/style/constants.dart';
import 'package:fineance/style/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FineanceButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const FineanceButton({
    required this.text,
    required this.onPressed,
    this.color = AppColors.blue,
  });

  const FineanceButton.positive({
    required this.text,
    required this.onPressed,
    this.color = AppColors.green,
  });

  const FineanceButton.negative({
    required this.text,
    required this.onPressed,
    this.color = AppColors.red,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Constants.kMarginLarge),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size?>(
              const Size(double.infinity, 70.0)),
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(Constants.kDefaultBorderRadius))),
        ),
        child: Text(
          text,
          style: AppTypography().extraLargeBold().copyWith(
            color: context.isDarkTheme ? AppColors.black : AppColors.white,
          ),
        ),
      ),
    );
  }
}
