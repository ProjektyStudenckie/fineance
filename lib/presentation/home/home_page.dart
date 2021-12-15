import 'package:fineance/components/fineance_loader.dart';
import 'package:fineance/injection/bloc_factory.dart';
import 'package:fineance/presentation/home/bloc/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
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
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is ChosenWallet) {
          return Scaffold(
            appBar: AppBar(title: Text(state.chosenWallet.toString())),
          );
        }

        return const Scaffold(body: Center(child: FineanceLoader()));
      },
    );
  }
}
