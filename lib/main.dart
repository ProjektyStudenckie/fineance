import 'package:easy_localization/easy_localization.dart';
import 'package:fimber/fimber.dart';
import 'package:fineance/injection/bloc_factory.dart';
import 'package:fineance/injection/hive_initializer.dart';
import 'package:fineance/injection/modules.dart';
import 'package:fineance/presentation/splash/bloc/splash_bloc.dart';
import 'package:fineance/presentation/theme_bloc/theme_bloc.dart';
import 'package:fineance/routing/router.gr.dart';
import 'package:fineance/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  Fimber.plantTree(DebugTree());
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final GetIt injector = GetIt.instance;
  await setupHive();
  registerModules(injector);

  runApp(Provider<BlocFactory>(
      create: (context) => BlocFactory(injector: injector),
      child: EasyLocalization(
          path: 'assets/translations',
          supportedLocales: const [Locale("en"), Locale("pl")],
          fallbackLocale: const Locale("en"),
          child: App())));
}

class App extends StatelessWidget {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    final BlocFactory blocFactory = BlocFactory.of(context);
    final ThemeBloc themeBloc = blocFactory.get();
    final SplashBloc splashBloc = blocFactory.get();

    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(create: (context) => themeBloc),
        BlocProvider<SplashBloc>(create: (context) => splashBloc)
      ],
      child: BlocConsumer<ThemeBloc, ThemeState>(
        listener: (context, state) {
          SystemChrome.setSystemUIOverlayStyle(state.theme == ThemeScheme.dark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark);
        },
        builder: (context, state) => Provider<ThemeScheme>(
          create: (BuildContext context) {
            return state.theme;
          },
          child: MaterialApp.router(
            theme: state.theme == ThemeScheme.dark ? themeDark : themeLight,
            routerDelegate: _router.delegate(),
            routeInformationParser: _router.defaultRouteParser(),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}
