import 'package:auto_route/auto_route.dart';
import 'package:fineance/presentation/add_wallet/add_wallet_page.dart';
import 'package:fineance/presentation/authorization/biometrics/biometrics_page.dart';
import 'package:fineance/presentation/authorization/login/login_page.dart';
import 'package:fineance/presentation/authorization/register/register_page.dart';
import 'package:fineance/presentation/home/home_page.dart';
import 'package:fineance/presentation/income_expense/income_expense_page.dart';
import 'package:fineance/presentation/onboarding/onboarding_page.dart';
import 'package:fineance/presentation/settings/settings_page.dart';
import 'package:fineance/presentation/splash/splash_page.dart';
import 'package:fineance/presentation/tabs/tab_page.dart';
import 'package:fineance/presentation/wallets/wallets_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: LoginPage),
    AutoRoute(page: RegisterPage),
    AutoRoute(page: OnboardingPage),
    AutoRoute(page: BiometricsPage),
    AutoRoute(page: IncomeExpensePage),
    AutoRoute(page: AddWalletPage),
    AutoRoute(page: TabPage, children: [
      AutoRoute(page: HomePage),
      AutoRoute(page: WalletsPage),
      AutoRoute(page: SettingsPage),
    ])
  ],
)
class $AppRouter {}
