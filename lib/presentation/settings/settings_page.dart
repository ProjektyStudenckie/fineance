import 'package:auto_route/auto_route.dart';
import 'package:fineance/components/fineance_button.dart';
import 'package:fineance/components/fineance_loader.dart';
import 'package:fineance/components/fineance_switch.dart';
import 'package:fineance/components/fineance_title.dart';
import 'package:fineance/extension/context_extension.dart';
import 'package:fineance/presentation/settings/bloc/settings_bloc.dart';
import 'package:fineance/presentation/theme_bloc/theme_bloc.dart';
import 'package:fineance/routing/router.gr.dart';
import 'package:fineance/style/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SettingsBloc>(context).add(InitializeSettings());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsLoaded) {
          return _buildPage(state);
        } else {
          return _buildLoader();
        }
      },
    );
  }

  Widget _buildPage(SettingsLoaded state) {
    return Scaffold(
        body: SafeArea(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const FineanceTitle(text: "settings"),
        const SizedBox(height: Dimens.kMarginExtraLarge),
        ..._buildOptions(state),
        const Spacer(),
        FineanceButton.negative(
            text: "logout",
            onPressed: () {
              context.router.replace(const SplashRoute());
            }),
        const SizedBox(height: Dimens.kMarginMedium),
      ]),
    ));
  }

  Widget _buildLoader() {
    return const Center(child: FineanceLoader());
  }

  List<Widget> _buildOptions(SettingsLoaded state) {
    return [
      _buildThemeOption(state),
      const SizedBox(height: Dimens.kMarginLarge),
      _buildBiometricsOption(state),
    ];
  }

  Widget _buildThemeOption(SettingsLoaded state) {
    return FineanceSwitch(
        label: "dark mode",
        value: context.isDarkTheme,
        onChanged: (newValue) {
          BlocProvider.of<SettingsBloc>(context).add(ChangeTheme(
              isDarkTheme: context.isDarkTheme, settings: state.settings));
          BlocProvider.of<ThemeBloc>(context).add(ChangeGlobalTheme(
              theme:
                  context.isDarkTheme ? ThemeScheme.light : ThemeScheme.dark));
        });
  }

  Widget _buildBiometricsOption(SettingsLoaded state) {
    return FineanceSwitch(
        label: "biometric authorization",
        value: state.settings.isBiometricsActive,
        onChanged: (newValue) {
          BlocProvider.of<SettingsBloc>(context).add(ChangeBiometricsOption(
              enable: newValue, settings: state.settings));
        });
  }
}
