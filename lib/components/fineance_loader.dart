import 'package:fineance/extension/context_extension.dart';
import 'package:fineance/style/dimens.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class FineanceLoader extends StatefulWidget {
  final double size;

  const FineanceLoader({this.size = Dimens.kLoaderSize});

  @override
  _FineanceLoaderState createState() => _FineanceLoaderState();
}

class _FineanceLoaderState extends State<FineanceLoader> {
  late RiveAnimationController _controller;
  final animationLight = "assets/animations/fineance_logo_light.riv";
  final animationDark = "assets/animations/fineance_logo_dark.riv";

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation('rotate');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: widget.size,
        width: widget.size,
        child: RiveAnimation.asset(
            context.isDarkTheme ? animationLight : animationDark));
  }
}
