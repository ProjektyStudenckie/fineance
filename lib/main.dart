import 'package:easy_localization/easy_localization.dart';
import 'package:fimber/fimber.dart';
import 'package:fineance/injection/bloc_factory.dart';
import 'package:fineance/injection/modules.dart';
import 'package:fineance/routing/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  Fimber.plantTree(DebugTree());
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final GetIt injector = GetIt.instance;
  registerModules(injector);

  runApp(Provider<BlocFactory>(
      create: (context) => BlocFactory(injector: injector),
      child: EasyLocalization(
          path: 'assets/translations',
          supportedLocales: const [Locale("en")],
          fallbackLocale: const Locale("en"),
          child: App())));
}

class App extends StatelessWidget {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.delegate(),
      routeInformationParser: _router.defaultRouteParser(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
