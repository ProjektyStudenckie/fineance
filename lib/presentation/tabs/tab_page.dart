import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fineance/generated/locale_keys.g.dart';
import 'package:fineance/injection/bloc_factory.dart';
import 'package:fineance/presentation/home/bloc/home_bloc.dart';
import 'package:fineance/presentation/settings/bloc/settings_bloc.dart';
import 'package:fineance/routing/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabPage extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    final BlocFactory blocFactory = BlocFactory.of(context);
    final HomeBloc homeBloc = blocFactory.get();
    final SettingsBloc settingsBloc = blocFactory.get();

    return MultiBlocProvider(providers: [
      BlocProvider<HomeBloc>(create: (context) => homeBloc),
      BlocProvider<SettingsBloc>(create: (context) => settingsBloc)
    ], child: this);
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      lazyLoad: false,
      animationDuration: const Duration(seconds: 0),
      routes: const [HomeRoute(), SettingsRoute()],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: LocaleKeys.tab_home.tr()),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: LocaleKeys.tab_settings.tr()),
            ]);
      },
    );
  }
}
