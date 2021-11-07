import 'package:fineance/extension/context_extension.dart';
import 'package:fineance/style/colors.dart';
import 'package:flutter/material.dart';

class FineanceValuesSwitch extends StatefulWidget {
  final String firstText;
  final String secondText;
  final Color firstColor;
  final Color secondColor;
  final void Function(int) onChange;

  const FineanceValuesSwitch({
    Key? key,
    required this.firstText,
    required this.secondText,
    required this.onChange,
    this.firstColor = AppColors.green,
    this.secondColor = AppColors.red,
  }) : super(key: key);

  @override
  _FineanceValuesSwitchState createState() => _FineanceValuesSwitchState();
}

class _FineanceValuesSwitchState extends State<FineanceValuesSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorTween;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _colorTween = ColorTween(begin: widget.firstColor, end: widget.secondColor)
        .animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Container(
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              color: context.isDarkTheme ? AppColors.white : AppColors.darkGrey,
              borderRadius: BorderRadius.circular(12.0)),
          child: AnimatedBuilder(
              animation: _colorTween,
              builder: (context, child) {
                return TabBar(
                    labelStyle: context.typo.smallBold(),
                    labelColor: AppColors.darkGrey,
                    unselectedLabelColor: context.isDarkTheme
                        ? AppColors.darkGrey
                        : AppColors.white,
                    indicator: BoxDecoration(
                        color: _colorTween.value,
                        borderRadius: BorderRadius.circular(8.0)),
                    isScrollable: true,
                    tabs: [
                      Tab(text: widget.firstText),
                      Tab(text: widget.secondText),
                    ],
                    onTap: (index) {
                      widget.onChange(index);

                      if (index == 0) {
                        _animationController.reverse();
                      } else {
                        _animationController.forward();
                      }
                    });
              }),
        ));
  }
}
