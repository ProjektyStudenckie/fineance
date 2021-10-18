import 'package:fineance/components/fineance_button.dart';
import 'package:fineance/components/fineance_text_field.dart';
import 'package:fineance/style/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Example use of new components
            FineanceButton(
              onPressed: () {},
              text: 'label',
            ),
            FineanceButton(
              onPressed: () {},
              text: 'label',
              color: AppColors.green,
            ),
            const FineanceTextField(label: 'label'),
          ],
        ),
      ),
    );
  }
}
