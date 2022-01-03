import 'package:fineance/extension/context_extension.dart';
import 'package:fineance/repositories/goal.dart';
import 'package:fineance/repositories/wallet.dart';
import 'package:fineance/style/colors.dart';
import 'package:fineance/style/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FineanceInfoTab extends StatefulWidget {
  final dynamic value;
  final bool isGoal;
  final VoidCallback deleteGoal;

  const FineanceInfoTab({
    Key? key,
    required this.value,
    required this.isGoal,
    required this.deleteGoal,
  }) : super(key: key);

  @override
  State<FineanceInfoTab> createState() => _FineanceInfoTabState();
}

class _FineanceInfoTabState extends State<FineanceInfoTab> {
  late Goal _goal;
  late Remittance _remittance;

  @override
  void initState() {
    if (widget.isGoal) {
      _goal = widget.value as Goal;
      _remittance = Remittance(description: '', date: '', value: 0);
    } else {
      _remittance = widget.value as Remittance;
      _goal = Goal(name: '', date: '', value: 0);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: AspectRatio(
        aspectRatio: 4.0,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color:
                    context.isDarkTheme ? AppColors.grey : AppColors.darkGrey),
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            color: context.isDarkTheme ? AppColors.darkGrey : AppColors.white,
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
                      widget.value.value.toString(),
                      style: AppTypography().largeBold().copyWith(
                          color: context.isDarkTheme
                              ? Colors.white
                              : Colors.black),
                    ),
                    Text(
                      !widget.isGoal ? _remittance.description : _goal.name,
                      style: AppTypography()
                          .main()
                          .copyWith(color: AppColors.grey),
                    )
                  ],
                ),
                _buildSign(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSign() {
    if (!widget.isGoal) {
      if (_remittance.value > 0) {
        return const CircleAvatar(
          backgroundColor: AppColors.green,
          child: Icon(
            Icons.add,
            color: AppColors.darkGrey,
          ),
        );
      }

      return const CircleAvatar(
        backgroundColor: AppColors.red,
        child: Icon(
          Icons.remove,
          color: AppColors.darkGrey,
        ),
      );
    }

    return GestureDetector(
      onTap: widget.deleteGoal,
      child: const CircleAvatar(
        backgroundColor: AppColors.red,
        child: Icon(
          Icons.delete,
          color: AppColors.darkGrey,
        ),
      ),
    );
  }
}
