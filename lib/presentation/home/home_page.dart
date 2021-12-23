import 'package:auto_route/auto_route.dart';
import 'package:fineance/components/fineance_loader.dart';
import 'package:fineance/extension/context_extension.dart';
import 'package:fineance/injection/bloc_factory.dart';
import 'package:fineance/localization/keys.g.dart';
import 'package:fineance/localization/utils.dart';
import 'package:fineance/presentation/home/bloc/home_bloc.dart';
import 'package:fineance/repositories/wallet.dart';
import 'package:fineance/style/colors.dart';
import 'package:fineance/style/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget implements AutoRouteWrapper {
  late Wallet wallet;

  @override
  Widget wrappedRoute(BuildContext context) {
    final BlocFactory blocFactory = BlocFactory.of(context);
    return BlocProvider<HomeBloc>(
      create: (context) => blocFactory.get<HomeBloc>(),
      child: this,
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(GetNewWallet());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        if (state is ChosenWallet) {
          widget.wallet = state.wallet;
          return Scaffold(
              appBar: _buildAppBar(),
              body: SafeArea( child: FutureBuilder(builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) { return const Center(child: FineanceLoader()); },))
          );
        }

        return const Scaffold(body: Center(child: FineanceLoader()));
      },
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
      widget.wallet.name,
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
          onPressed: () async {
          },
          backgroundColor: AppColors.green,
          child: const Icon(Icons.add),
        ),
      ),
    ),
  );
}
