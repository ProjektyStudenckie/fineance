import 'package:fineance/extension/context_extension.dart';
import 'package:fineance/style/colors.dart';
import 'package:fineance/style/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FineanceTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;

  const FineanceTextField(
      {required this.label,
      this.controller,
      this.obscureText = false,
      this.validator,
      this.textInputAction,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.kDefaultBorderRadius),
        color: AppColors.lightGrey,
      ),
      margin: const EdgeInsets.symmetric(
          horizontal: Dimens.kMarginLargeDouble, vertical: Dimens.kMarginLarge),
      padding: const EdgeInsets.all(Dimens.kMarginLarge),
      child: TextFormField(
        style: context.typo.main(),
        controller: controller,
        maxLines: 1,
        obscureText: obscureText,
        validator: validator,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: context.typo.main(),
          filled: true,
          fillColor: AppColors.lightGrey,
          isDense: true,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
