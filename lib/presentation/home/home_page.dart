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
    //BlocProvider.of<HomeBloc>(context).add(GetNewWallet());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: BlocProvider.of<HomeBloc>(context).walletsStream,
        builder: (context, snapshot) {
          return Scaffold(
            body: Center(
              child: Text(snapshot.data.toString()),
            ),
          );
        });
    // return BlocBuilder<HomeBloc, HomeState>(
    //   builder: (context, state) {
    //     if (state is ChosenWallet) {
    //       return Scaffold(
    //         appBar: AppBar(title: Text(state.chosenWallet.toString())),
    //       );
    //     }
    //
    //     return const Scaffold(body: Center(child: FineanceLoader()));
    //   },
    // );
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
