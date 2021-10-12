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
          floatingActionButton: FloatingActionButton(
            child: Text(state.theme == ThemeScheme.light ? "dark" : "light"),
            onPressed: () {
              BlocProvider.of<SettingsBloc>(context).add(ChangeTheme());
              BlocProvider.of<ThemeBloc>(context).add(ChangeGlobalTheme(
                  theme: state.theme == ThemeScheme.light
                      ? ThemeScheme.dark
                      : ThemeScheme.light));
            },
          ),
          body: const Center(
            child: Text("Settings Page"),
          ),
        );
      },
    );
  }
}
