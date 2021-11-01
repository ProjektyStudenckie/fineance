import 'package:fineance/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData themeDark = ThemeData.dark().copyWith(
  bottomAppBarColor: AppColors.darkGrey,
  appBarTheme: const AppBarTheme(backgroundColor: AppColors.darkGrey),
  scaffoldBackgroundColor: AppColors.darkGrey,
);

ThemeData themeLight = ThemeData.light().copyWith(
  indicatorColor: AppColors.darkGrey,
  appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark)
);
