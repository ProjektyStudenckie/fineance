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
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                primary: AppColors.blue,
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 7.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
