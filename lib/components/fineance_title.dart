import 'package:fineance/extension/context_extension.dart';
import 'package:fineance/style/colors.dart';
import 'package:fineance/style/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FineanceTitle extends StatelessWidget {
  final String text;

  const FineanceTitle({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: Dimens.kMarginLargeDouble,
          left: Dimens.kMarginLargeDouble,
          right: Dimens.kMarginLargeDouble),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(text,
            overflow: TextOverflow.ellipsis,
            style: context.typo.extraLargeBold(
                color: context.isDarkTheme ? AppColors.white : AppColors.black)),
      ),
    );
  }
}
