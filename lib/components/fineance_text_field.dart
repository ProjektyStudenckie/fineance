import 'package:fineance/extension/context_extension.dart';
import 'package:fineance/style/colors.dart';
import 'package:fineance/style/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FineanceTextField extends StatelessWidget {
  final String label;

  const FineanceTextField({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Constants.kDefaultBorderRadius),
        color: AppColors.lightGrey,
      ),
      margin: const EdgeInsets.all(Constants.kMarginLarge),
      padding: const EdgeInsets.all(Constants.kMarginLarge),
      child: TextFormField(
        maxLines: 1,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: context.typo.large(),
          filled: true,
          fillColor: AppColors.lightGrey,
          isDense: true,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
