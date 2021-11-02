import 'package:auto_route/auto_route.dart';
import 'package:fineance/components/fineance_loader.dart';
import 'package:fineance/extension/context_extension.dart';
import 'package:fineance/injection/bloc_factory.dart';
import 'package:fineance/localization/keys.g.dart';
import 'package:fineance/localization/utils.dart';
import 'package:fineance/presentation/splash/bloc/splash_bloc.dart';
import 'package:fineance/presentation/splash/fineance_quick_actions.dart';
import 'package:fineance/routing/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_actions/quick_actions.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    const QuickActions quickActions = QuickActions();
    bool isOpenedFromQuickAction = false;

    quickActions.initialize((String shortcutType) async {
      if (shortcutType ==
          LocaleKeys.quick_actions_register_new_income_expense) {
        isOpenedFromQuickAction = true;
        BlocProvider.of<SplashBloc>(context)
            .add(LoadApp(FineanceQuickActions.REGISTER_NEW_INCOME_EXPENSE));
      }
    });

    _setQuickActions(quickActions);

    if (!isOpenedFromQuickAction) {
      BlocProvider.of<SplashBloc>(context).add(LoadApp());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashOpenHome) {
          context.router.replace(const LoginRoute()); //TabRoute());
        } else if (state is SplashOpenBiometrics) {
          context.router
              .replace(BiometricsRoute(quickAction: state.quickAction));
        } else if (state is SplashOpenRegisterIncomeExpense) {
          context.router.replace(const TabRoute(children: [SettingsRoute()]));
        }
      },
      builder: (context, state) {
        SystemChrome.setSystemUIOverlayStyle(context.isDarkTheme
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark);

        return const Scaffold(
          body: Center(child: FineanceLoader()),
        );
      },
    );
  }

  void _setQuickActions(QuickActions quickActions) {
    quickActions.setShortcutItems(<ShortcutItem>[
      ShortcutItem(
          type: LocaleKeys.quick_actions_register_new_income_expense,
          localizedTitle:
              translate(LocaleKeys.quick_actions_register_new_income_expense)),
    ]);
  }
}
