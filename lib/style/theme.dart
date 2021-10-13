import 'package:fineance/style/colors.dart';
import 'package:flutter/material.dart';

ThemeData themeDark = ThemeData.dark().copyWith(
  bottomAppBarColor: AppColors.darkGrey,
  appBarTheme: const AppBarTheme(backgroundColor: AppColors.darkGrey),
  scaffoldBackgroundColor: AppColors.darkGrey,
);

ThemeData themeLight = ThemeData.light();
