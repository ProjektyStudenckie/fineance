import 'package:fineance/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FineanceBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FineanceBackButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: InkWell(
        splashColor: Colors.blue,
        highlightColor: AppColors.blue,
        customBorder: const CircleBorder(side: BorderSide()),
        onTap: () {},
        child: Ink(
            decoration: const BoxDecoration(
                color: AppColors.blue, shape: BoxShape.circle),
            child: const Icon(Icons.chevron_left_rounded, size: 32, color: Colors.white)),
      ),
    );
  }
}
