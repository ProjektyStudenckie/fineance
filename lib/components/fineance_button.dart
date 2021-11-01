import 'package:fineance/extension/context_extension.dart';
import 'package:fineance/style/colors.dart';
import 'package:fineance/style/dimens.dart';
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
    Key? key,
  }) : super(key: key);

  const FineanceButton.positive({
    required this.text,
    required this.onPressed,
    this.color = AppColors.green,
    Key? key,
  }) : super(key: key);

  const FineanceButton.negative({
    required this.text,
    required this.onPressed,
    this.color = AppColors.red,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimens.kMarginLargeDouble, vertical: Dimens.kMarginLarge),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size?>(
              const Size(double.infinity, 75.0)),
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(Dimens.kDefaultBorderRadius))),
        ),
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: AppTypography().largeBold().copyWith(
                color: context.isDarkTheme ? AppColors.black : AppColors.white,
              ),
        ),
      ),
    );
  }
}
