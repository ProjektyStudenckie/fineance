import 'package:fineance/style/colors.dart';
import 'package:fineance/style/constants.dart';
import 'package:fineance/style/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FineanceTextField extends StatelessWidget {
  const FineanceTextField({
    required this.hint,
    Key? key,
  }) : super(key: key);

  final String hint;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Constants.kNormalWidgetWidth,
      height: Constants.kNormalWidgetHeight,
      child: TextField(
        style: AppTypography().main(),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTypography().main(),
          fillColor: AppColors.lightGrey,
          filled: true,
          contentPadding: const EdgeInsets.all(10.0),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightGrey),
          ),
        ),
      ),
    );
  }
}
