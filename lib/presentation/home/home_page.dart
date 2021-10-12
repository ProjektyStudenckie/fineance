import 'package:fineance/main/bloc/theme_bloc.dart';
import 'package:fineance/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ThemeScheme _theme = ThemeScheme.light;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Text('theme'),
        onPressed: () {
          setState(() {
            if (_theme == ThemeScheme.light) {
              _theme = ThemeScheme.dark;
            } else {
              _theme = ThemeScheme.light;
            }
          });
          BlocProvider.of<ThemeBloc>(context).add(ChangeTheme(theme: _theme));
        },
      ),
      appBar: AppBar(
          leading: IconButton(
        icon: const Icon(
          Icons.account_circle,
          color: AppColors.darkBlue,
        ),
        onPressed: () {},
      )),
      body: const Center(
        child: Text("Home"),
      ),
    );
  }
}
