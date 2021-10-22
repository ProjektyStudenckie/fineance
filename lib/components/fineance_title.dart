import 'package:fineance/extension/context_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FineanceTitle extends StatelessWidget {
  final String text;

  const FineanceTitle({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24),
      child: Text(text,
          overflow: TextOverflow.ellipsis,
          style: context.typo.extraLargeBold(
              color: context.isDarkTheme ? Colors.white : Colors.black)),
    );
  }
}
