import 'package:fineance/extension/context_extension.dart';
import 'package:fineance/repositories/wallet.dart';
import 'package:fineance/style/colors.dart';
import 'package:fineance/style/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FineanceInfoTab extends StatelessWidget {
  const FineanceInfoTab({
    Key? key,
    required this.remittance,
  }) : super(key: key);

  final Remittance remittance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: AspectRatio(
        aspectRatio: 3.4,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: context.isDarkTheme ? AppColors.grey : AppColors.white),
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            color: context.isDarkTheme ? AppColors.darkGrey : AppColors.grey,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      remittance.value.toString(),
                      style: AppTypography().largeBold().copyWith(
                          color: context.isDarkTheme
                              ? Colors.white
                              : Colors.black),
                    ),
                    Text(
                      remittance.description,
                      style: AppTypography()
                          .main()
                          .copyWith(color: AppColors.grey),
                    )
                  ],
                ),
                if (remittance.value > 0)
                  const CircleAvatar(
                    backgroundColor: AppColors.green,
                    child: Icon(
                      Icons.add,
                      color: AppColors.darkGrey,
                    ),
                  )
                else
                  const CircleAvatar(
                    backgroundColor: AppColors.red,
                    child: Icon(
                      Icons.remove,
                      color: AppColors.darkGrey,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
