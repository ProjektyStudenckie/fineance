import 'package:fineance/style/colors.dart';
import 'package:flutter/material.dart';

ThemeData themeDark = ThemeData.dark().copyWith(
  bottomAppBarColor: AppColors.extraDarkGrey,
  appBarTheme: const AppBarTheme(backgroundColor: AppColors.extraDarkGrey),
  scaffoldBackgroundColor: AppColors.darkGrey,
);

ThemeData themeLight = ThemeData.light();
