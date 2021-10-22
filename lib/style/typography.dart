import 'package:fineance/style/colors.dart';
import 'package:flutter/material.dart';

class AppTypography {
  TextStyle main({Color? color = AppColors.darkGrey}) {
    return TextStyle(fontSize: 19.0, fontWeight: FontWeight.w400, color: color);
  }

  TextStyle mainMediumBold({Color color = AppColors.darkGrey}) {
    return TextStyle(fontSize: 19.0, fontWeight: FontWeight.w600, color: color);
  }

  TextStyle mainBold({Color color = AppColors.darkGrey}) {
    return TextStyle(fontSize: 19.0, fontWeight: FontWeight.w700, color: color);
  }

  TextStyle large({Color color = AppColors.darkGrey}) {
    return TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400, color: color);
  }

  TextStyle largeMediumBold({Color color = AppColors.darkGrey}) {
    return TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: color);
  }

  TextStyle largeBold({Color color = AppColors.darkGrey}) {
    return TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700, color: color);
  }

  TextStyle extraLarge({Color color = AppColors.darkGrey}) {
    return TextStyle(fontSize: 32.0, fontWeight: FontWeight.w400, color: color);
  }

  TextStyle extraLargeLight({Color color = AppColors.darkGrey}) {
    return TextStyle(fontSize: 32.0, fontWeight: FontWeight.w300, color: color);
  }

  TextStyle extraLargeBold({Color color = AppColors.darkGrey}) {
    return TextStyle(fontSize: 32.0, fontWeight: FontWeight.w700, color: color);
  }

  TextStyle small({Color color = AppColors.darkGrey}) {
    return TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: color);
  }

  TextStyle smallBold({Color color = AppColors.darkGrey}) {
    return TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: color);
  }

  TextStyle extraSmall({Color color = AppColors.darkGrey}) {
    return TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: color);
  }

  TextStyle extraSmallBold({Color color = AppColors.darkGrey}) {
    return TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: color);
  }
}
