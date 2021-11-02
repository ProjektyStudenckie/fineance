import 'package:bloc_test/bloc_test.dart';
import 'package:fineance/injection/modules.dart';
import 'package:fineance/presentation/authorization/login/bloc/login_bloc.dart';
import 'package:fineance/repositories/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthorizationRepository extends Mock
    implements AuthenticationRepository {}

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

class MockSettingsBox extends Mock implements Box {}

Future<void> main() async {
  MockAuthorizationRepository mockAuthorizationRepository;
  MockSettingsBox mockSettingsBox;
  late LoginBloc loginBloc;

  setUp(() async {
    mockAuthorizationRepository = MockAuthorizationRepository();
    mockSettingsBox = MockSettingsBox();

    loginBloc = LoginBloc(
      mockAuthorizationRepository,
      mockSettingsBox,
    );
  });

  tearDown(() {
    loginBloc.close();
  });

  group('login bloc tests group', () {
    mockAuthorizationRepository = MockAuthorizationRepository();
    mockSettingsBox = MockSettingsBox();
    const username = "";
    const password = "";

    void mockLoginUserTrue() {
      when(() => mockAuthorizationRepository.login(username, password))
          .thenAnswer((invocation) async => true);
    }

    void mockLoginUserFalse() {
      when(() => mockAuthorizationRepository.login(username, password))
          .thenAnswer((invocation) async => false);
    }

    void mockSettingsBoxGet() {
      when(() => mockSettingsBox.get(IS_ONBOARDING_DONE))
          .thenAnswer((invocation) => true);
    }

    test('bloc should have initial state as [InitialState]', () {
      expect(loginBloc.state.runtimeType, LoginInitial);
    });

    blocTest<LoginBloc, LoginState>("emit [LoginError] if there's an error",
        build: () {
          return loginBloc;
        },
        act: (LoginBloc bloc) =>
            bloc.add(LoginUser(username: username, password: password)),
        expect: () => [
              LoginLoading(),
              LoginError(),
            ]);

    blocTest<LoginBloc, LoginState>('emit [LoginSuccess] if user is logged in',
        build: () {
          mockLoginUserTrue();
          mockSettingsBoxGet();
          return loginBloc;
        },
        act: (LoginBloc bloc) =>
            bloc.add(LoginUser(username: username, password: password)),
        expect: () => [
              LoginLoading(),
              LoginSuccess(shouldShowOnboarding: false),
            ]);

    blocTest<LoginBloc, LoginState>(
        'emit [LoginIncorrect] if user is not logged in',
        build: () {
          mockLoginUserFalse();
          mockSettingsBoxGet();
          return loginBloc;
        },
        act: (LoginBloc bloc) =>
            bloc.add(LoginUser(username: username, password: password)),
        expect: () => [
              LoginLoading(),
              LoginIncorrect(),
            ]);
  });
}
