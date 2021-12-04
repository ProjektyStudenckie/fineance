import 'package:fineance/components/fineance_list.dart';
import 'package:fineance/extension/context_extension.dart';
import 'package:fineance/localization/keys.g.dart';
import 'package:fineance/localization/utils.dart';
import 'package:fineance/style/colors.dart';
import 'package:fineance/style/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalletsPage extends StatefulWidget {
  const WalletsPage({Key? key}) : super(key: key);

  @override
  _WalletsPageState createState() => _WalletsPageState();
}

class _WalletsPageState extends State<WalletsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: const SafeArea(
        child: FineanceList(),
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(
        backgroundColor:
            context.isDarkTheme ? AppColors.darkGrey : AppColors.white,
        elevation: 0.0,
        leading: _buildAppBarLeading(),
        automaticallyImplyLeading: false,
        leadingWidth: 500.0,
        toolbarHeight: 100.0,
        actions: [_buildActions()],
      );

  Widget _buildAppBarLeading() => Padding(
        padding: const EdgeInsets.only(
          top: Dimens.kMarginLargeDouble,
          left: Dimens.kMarginLargeDouble,
        ),
        child: Text(
          translate(LocaleKeys.tab_wallets).replaceAll('s', ''),
          style: context.typo.extraLargeBold(
              color: context.isDarkTheme ? AppColors.white : AppColors.black),
        ),
      );

  Widget _buildActions() => Padding(
        padding: const EdgeInsets.only(right: Dimens.kMarginLargeDouble),
        child: SizedBox(
          height: 45.0,
          width: 45.0,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: AppColors.blue,
              child: const Icon(Icons.add),
            ),
          ),
        ),
      );
}
