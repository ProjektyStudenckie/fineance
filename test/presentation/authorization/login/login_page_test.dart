import 'package:bloc_test/bloc_test.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fineance/localization/keys.g.dart';
import 'package:fineance/localization/utils.dart';
import 'package:fineance/presentation/authorization/login/bloc/login_bloc.dart';
import 'package:fineance/presentation/authorization/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

class FakeLoginEvent extends Fake implements LoginEvent {}

// ignore: avoid_implementing_value_types
class FakeLoginState extends Fake implements LoginState {}

Future<void> main() async {
  group("Login page test", () {
    late LoginBloc bloc;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      WidgetsFlutterBinding.ensureInitialized();
      await EasyLocalization.ensureInitialized();
      bloc = MockLoginBloc();
    });

    setUpAll(() {
      registerFallbackValue(FakeLoginEvent());
      registerFallbackValue(FakeLoginState());
    });

    const String loginTitle = 'loginTitle';
    const String registerTitle = 'registerTitle';
    const String usernameInput = 'usernameInput';
    const String passwordInput = 'passwordInput';
    const String loginButton = 'loginButton';
    const String registerButton = 'registerButton';

    testWidgets("should show login screen when initial state emitted",
        (WidgetTester tester) async {
      whenListen(
        bloc,
        const Stream<LoginState>.empty(),
        initialState: LoginInitial(),
      );

      await tester.pumpWidget(
        BlocProvider<LoginBloc>.value(
            value: bloc,
            child: EasyLocalization(
              supportedLocales: const [Locale('pl')],
              path: 'assets/translations',
              fallbackLocale: const Locale('pl'),
              child: MaterialApp(
                home: LoginPage(),
              ),
            )),
      );

      expect(find.byKey(const Key(loginTitle)), findsOneWidget);
      expect(find.byKey(const Key(registerTitle)), findsNothing);
      expect(find.byKey(const Key(usernameInput)), findsOneWidget);
      expect(find.byKey(const Key(passwordInput)), findsOneWidget);
      expect(find.byKey(const Key(loginButton)), findsOneWidget);
      expect(find.byKey(const Key(registerButton)), findsOneWidget);
    });

    testWidgets(
        "should show validation error when username and password fields empty and login button pressed",
        (WidgetTester tester) async {
      whenListen(
        bloc,
        const Stream<LoginState>.empty(),
        initialState: LoginInitial(),
      );

      await tester.pumpWidget(
        BlocProvider<LoginBloc>.value(
            value: bloc,
            child: EasyLocalization(
              supportedLocales: const [Locale('pl')],
              path: 'assets/translations',
              fallbackLocale: const Locale('pl'),
              child: MaterialApp(
                home: LoginPage(),
              ),
            )),
      );

      expect(find.text(translate(LocaleKeys.validation_username_is_required)),
          findsNothing);
      expect(find.text(translate(LocaleKeys.validation_password_is_required)),
          findsNothing);

      await tester.tap(find.byKey(const ValueKey(loginButton)));
      await tester.pumpAndSettle();

      expect(find.text(translate(LocaleKeys.validation_username_is_required)),
          findsOneWidget);
      expect(find.text(translate(LocaleKeys.validation_password_is_required)),
          findsOneWidget);
    });
  });
}
