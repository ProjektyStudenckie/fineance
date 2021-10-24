import 'package:auto_route/auto_route.dart';
import 'package:fineance/presentation/authentication/login/login_page.dart';
import 'package:fineance/presentation/home/home_page.dart';
import 'package:fineance/presentation/onboarding/onboarding_page.dart';
import 'package:fineance/presentation/settings/settings_page.dart';
import 'package:fineance/presentation/splash/splash_page.dart';
import 'package:fineance/presentation/tabs/tab_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: LoginPage),
    AutoRoute(page: OnboardingPage),
    AutoRoute(page: TabPage, children: [
      AutoRoute(page: HomePage),
      AutoRoute(page: SettingsPage),
    ])
  ],
)
class $AppRouter {}
