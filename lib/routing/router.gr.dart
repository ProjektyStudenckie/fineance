// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;

import '../presentation/authorization/biometrics/biometrics_page.dart' as _i5;
import '../presentation/authorization/login/login_page.dart' as _i2;
import '../presentation/authorization/register/register_page.dart' as _i3;
import '../presentation/home/home_page.dart' as _i8;
import '../presentation/income_expense/income_expense_page.dart' as _i6;
import '../presentation/onboarding/onboarding_page.dart' as _i4;
import '../presentation/settings/settings_page.dart' as _i9;
import '../presentation/splash/fineance_quick_actions.dart' as _i12;
import '../presentation/splash/splash_page.dart' as _i1;
import '../presentation/tabs/tab_page.dart' as _i7;

class AppRouter extends _i10.RootStackRouter {
  AppRouter([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.SplashPage());
    },
    LoginRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.LoginPage());
    },
    RegisterRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.RegisterPage());
    },
    OnboardingRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.OnboardingPage());
    },
    BiometricsRoute.name: (routeData) {
      final args = routeData.argsAs<BiometricsRouteArgs>(
          orElse: () => const BiometricsRouteArgs());
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.BiometricsPage(quickAction: args.quickAction));
    },
    IncomeExpenseRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: _i6.IncomeExpensePage());
    },
    TabRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: _i7.TabPage());
    },
    HomeRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: _i8.HomePage());
    },
    SettingsRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: _i9.SettingsPage());
    }
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(SplashRoute.name, path: '/'),
        _i10.RouteConfig(LoginRoute.name, path: '/login-page'),
        _i10.RouteConfig(RegisterRoute.name, path: '/register-page'),
        _i10.RouteConfig(OnboardingRoute.name, path: '/onboarding-page'),
        _i10.RouteConfig(BiometricsRoute.name, path: '/biometrics-page'),
        _i10.RouteConfig(IncomeExpenseRoute.name, path: '/income-expense-page'),
        _i10.RouteConfig(TabRoute.name, path: '/tab-page', children: [
          _i10.RouteConfig(HomeRoute.name, path: 'home-page'),
          _i10.RouteConfig(SettingsRoute.name, path: 'settings-page')
        ])
      ];
}

/// generated route for [_i1.SplashPage]
class SplashRoute extends _i10.PageRouteInfo<void> {
  const SplashRoute() : super(name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for [_i2.LoginPage]
class LoginRoute extends _i10.PageRouteInfo<void> {
  const LoginRoute() : super(name, path: '/login-page');

  static const String name = 'LoginRoute';
}

/// generated route for [_i3.RegisterPage]
class RegisterRoute extends _i10.PageRouteInfo<void> {
  const RegisterRoute() : super(name, path: '/register-page');

  static const String name = 'RegisterRoute';
}

/// generated route for [_i4.OnboardingPage]
class OnboardingRoute extends _i10.PageRouteInfo<void> {
  const OnboardingRoute() : super(name, path: '/onboarding-page');

  static const String name = 'OnboardingRoute';
}

/// generated route for [_i5.BiometricsPage]
class BiometricsRoute extends _i10.PageRouteInfo<BiometricsRouteArgs> {
  BiometricsRoute({_i12.FineanceQuickActions? quickAction})
      : super(name,
            path: '/biometrics-page',
            args: BiometricsRouteArgs(quickAction: quickAction));

  static const String name = 'BiometricsRoute';
}

class BiometricsRouteArgs {
  const BiometricsRouteArgs({this.quickAction});

  final _i12.FineanceQuickActions? quickAction;
}

/// generated route for [_i6.IncomeExpensePage]
class IncomeExpenseRoute extends _i10.PageRouteInfo<void> {
  const IncomeExpenseRoute() : super(name, path: '/income-expense-page');

  static const String name = 'IncomeExpenseRoute';
}

/// generated route for [_i7.TabPage]
class TabRoute extends _i10.PageRouteInfo<void> {
  const TabRoute({List<_i10.PageRouteInfo>? children})
      : super(name, path: '/tab-page', initialChildren: children);

  static const String name = 'TabRoute';
}

/// generated route for [_i8.HomePage]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: 'home-page');

  static const String name = 'HomeRoute';
}

/// generated route for [_i9.SettingsPage]
class SettingsRoute extends _i10.PageRouteInfo<void> {
  const SettingsRoute() : super(name, path: 'settings-page');

  static const String name = 'SettingsRoute';
}
