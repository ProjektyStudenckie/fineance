import 'package:auto_route/auto_route.dart';
import 'package:fineance/extension/context_extension.dart';
import 'package:fineance/injection/bloc_factory.dart';
import 'package:fineance/presentation/authorization/biometrics/bloc/biometrics_bloc.dart';
import 'package:fineance/routing/router.gr.dart';
import 'package:fineance/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BiometricsPage extends StatefulWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    final BlocFactory blocFactory = BlocFactory.of(context);
    return BlocProvider<BiometricsBloc>(
      create: (context) => blocFactory.get<BiometricsBloc>(),
      child: this,
    );
  }

  @override
  _BiometricsPageState createState() => _BiometricsPageState();
}

class _BiometricsPageState extends State<BiometricsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BiometricsBloc, BiometricsState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.router.replace(const TabRoute());
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Sending Message"),
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildAuthenticateLabel(),
                  _buildAuthenticateButton(),
                ]),
          ),
        );
      },
    );
  }

  Widget _buildAuthenticateLabel() {
    return Column(
      children: [
        Text(
          "authenticate",
          style: context.typo.extraLargeBold(
              color: context.isDarkTheme ? AppColors.white : AppColors.black),
        ),
        AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(milliseconds: 400),
          child: TextButton(
              onPressed: () {
                context.router.replace(const LoginRoute());
              },
              child: Text("login",
                  style: context.typo
                      .main(color: AppColors.red)
                      .copyWith(decoration: TextDecoration.underline))),
        ),
      ],
    );
  }

  Widget _buildAuthenticateButton() {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.blue,
      ),
      child: IconButton(
        iconSize: 55.0,
        color: AppColors.white,
        splashColor: AppColors.green,
        icon: const Icon(Icons.fingerprint),
        onPressed: () {
          BlocProvider.of<BiometricsBloc>(context).add(TryToAuth());
        },
      ),
    );
  }
}
