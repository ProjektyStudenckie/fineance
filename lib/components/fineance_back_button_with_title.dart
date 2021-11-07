import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:fineance/components/fineance_back_button.dart';
import 'package:fineance/components/fineance_title.dart';
import 'package:flutter/material.dart';

class FineanceBackButtonWithTitle extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const FineanceBackButtonWithTitle(
      {Key? key, required this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FineanceBackButton(
            onPressed: onPressed ??
                () {
                  context.router.pop();
                }),
        Expanded(child: FittedBox(child: FineanceTitle(text: text))),
      ],
    );
  }
}
