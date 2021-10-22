import 'package:fineance/components/fineance_switch.dart';
import 'package:fineance/components/fineance_title.dart';
import 'package:fineance/extension/context_extension.dart';
import 'package:fineance/presentation/settings/bloc/settings_bloc.dart';
import 'package:fineance/presentation/theme_bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();

    final theme = Provider.of<ThemeScheme>(context, listen: false);
    BlocProvider.of<SettingsBloc>(context)
        .add(InitializeSettings(theme: theme));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Scaffold(
            body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const FineanceTitle(text: "settings"),
            const SizedBox(height: 16.0),
            ..._buildOptions(),
          ]),
        ));
      },
    );
  }

  List<Widget> _buildOptions() {
    return [
      FineanceSwitch(
          label: "dark mode",
          value: context.isDarkTheme,
          onChanged: (newValue) {
            BlocProvider.of<SettingsBloc>(context).add(ChangeTheme());
            BlocProvider.of<ThemeBloc>(context).add(ChangeGlobalTheme(
                theme: context.isDarkTheme
                    ? ThemeScheme.light
                    : ThemeScheme.dark));
          }),
    ];
  }
}
