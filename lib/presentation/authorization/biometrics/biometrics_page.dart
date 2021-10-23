import 'package:auto_route/auto_route.dart';
import 'package:fineance/injection/bloc_factory.dart';
import 'package:fineance/presentation/authorization/biometrics/bloc/biometrics_bloc.dart';
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
    return BlocBuilder<BiometricsBloc, BiometricsState>(
      builder: (context, state) {
        return const Center(
          child: Icon(Icons.fingerprint),
        );
      },
    );
  }
}
