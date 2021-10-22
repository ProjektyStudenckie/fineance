import 'package:auto_route/auto_route.dart';
import 'package:fineance/components/fineance_loader.dart';
import 'package:fineance/injection/bloc_factory.dart';
import 'package:fineance/presentation/splash/bloc/splash_bloc.dart';
import 'package:fineance/routing/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    final BlocFactory blocFactory = BlocFactory.of(context);
    return BlocProvider<SplashBloc>(
      create: (context) => blocFactory.get<SplashBloc>(),
      child: this,
    );
  }

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SplashBloc>(context).add(LoadApp());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashOpenHome) {
          context.router.replace(const LoginRoute()); //TabRoute());
        }
      },
      builder: (context, state) {
        return const Scaffold(
          body: Center(child: FineanceLoader()),
        );
      },
    );
  }
}
