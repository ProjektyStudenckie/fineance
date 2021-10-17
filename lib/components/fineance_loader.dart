import 'package:fineance/style/constants.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class FineanceLoader extends StatefulWidget {
  final double size;

  const FineanceLoader({this.size = Constants.kLoaderSize});

  @override
  _FineanceLoaderState createState() => _FineanceLoaderState();
}

class _FineanceLoaderState extends State<FineanceLoader> {
  late RiveAnimationController _controller;

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
        child: const RiveAnimation.asset(
            "assets/animations/fineance_logo_dark.riv"));
  }
}
