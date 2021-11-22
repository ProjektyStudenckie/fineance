import 'package:auto_route/auto_route.dart';
import 'package:fineance/components/fineance_loading_indicator.dart';
import 'package:fineance/localization/keys.g.dart';
import 'package:fineance/localization/utils.dart';
import 'package:fineance/routing/router.gr.dart';
import 'package:fineance/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.router.push(const IncomeExpenseRoute());
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FineanceProgressIndicator(
              topText: translate(LocaleKeys.progress_indicator_you_completed),
              bottomText:
                  translate(LocaleKeys.progress_indicator_of_savings_goal),
              completedPercent: 0.5,
              barColor: AppColors.red,
            ),
          ],
        ),
      ),
    );
  }
}
