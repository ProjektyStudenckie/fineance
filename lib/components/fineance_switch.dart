import 'dart:io';

import 'package:fineance/extension/context_extension.dart';
import 'package:fineance/style/colors.dart';
import 'package:fineance/style/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FineanceSwitch extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const FineanceSwitch(
      {Key? key,
      required this.label,
      required this.value,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Dimens.kMarginLargeDouble),
      child: Row(
        children: [
          Expanded(
            child: Text(label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.typo.main(
                    color: context.isDarkTheme
                        ? AppColors.white
                        : AppColors.black)),
          ),
          SizedBox(height: 40.0, child: _buildSwitch()),
        ],
      ),
    );
  }

  Widget _buildSwitch() {
    if (Platform.isIOS) {
      return _buildCupertinoSwitch();
    }
    return _buildMaterialSwitch();
  }

  Widget _buildCupertinoSwitch() {
    return CupertinoSwitch(
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.green,
      trackColor: AppColors.red,
    );
  }

  Widget _buildMaterialSwitch() {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeTrackColor: AppColors.green,
      inactiveTrackColor: AppColors.red,
      thumbColor: MaterialStateProperty.all(AppColors.white),
    );
  }
}
