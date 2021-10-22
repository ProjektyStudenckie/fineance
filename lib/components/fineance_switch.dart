import 'package:fineance/extension/context_extension.dart';
import 'package:fineance/style/colors.dart';
import 'package:fineance/style/dimens.dart';
import 'package:flutter/material.dart';

class FineanceSwitch extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const FineanceSwitch(
      {required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.kMarginLargeDouble),
      child: Row(
        children: [
          Text(label,
              style: context.typo.main(
                  color: context.isDarkTheme ? AppColors.white : AppColors.black)),
          const Spacer(),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
