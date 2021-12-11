import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:fineance/components/fineance_list.dart';
import 'package:fineance/extension/context_extension.dart';
import 'package:fineance/localization/keys.g.dart';
import 'package:fineance/localization/utils.dart';
import 'package:fineance/repositories/wallets_repository.dart';
import 'package:fineance/routing/router.gr.dart';
import 'package:fineance/style/colors.dart';
import 'package:fineance/style/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/wallets_bloc.dart';

class WalletsPage extends StatefulWidget {
  const WalletsPage({Key? key}) : super(key: key);

  @override
  _WalletsPageState createState() => _WalletsPageState();

}

class _WalletsPageState extends State<WalletsPage> {
  late WalletRepository walletRepository;
  @override
  void initState() {
    super.initState();

    walletRepository = BlocProvider.of<WalletsBloc>(context).walletRepository;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: FineanceList(walletRepository: walletRepository),
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
              onPressed: () => context.router.push(const AddWalletRoute()),
              backgroundColor: AppColors.green,
              child: const Icon(Icons.add),
            ),
          ),
        ),
      );
}
