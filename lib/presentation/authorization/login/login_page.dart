import 'package:auto_route/auto_route.dart';
import 'package:fineance/injection/bloc_factory.dart';
import 'package:fineance/localization/keys.g.dart';
import 'package:fineance/localization/utils.dart';
import 'package:fineance/presentation/authorization/login/bloc/login_bloc.dart';
import 'package:fineance/routing/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget implements AutoRouteWrapper {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    final BlocFactory blocFactory = BlocFactory.of(context);
    return BlocProvider<LoginBloc>(
      create: (context) => blocFactory.get<LoginBloc>(),
      child: this,
    );
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          if (state.shouldShowOnboarding) {
            context.router.replace(const OnboardingRoute());
          } else {
            context.router.replace(const TabRoute());
          }
        } else if (state is LoginError) {
          // TODO: Display error to the user
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                _buildUsernameField(),
                _buildPassword(),
                _buildConfirmButton(),
                _buildRegisterButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUsernameField() {
    return TextField(
      controller: _usernameController,
    );
  }

  Widget _buildPassword() {
    return TextField(
      controller: _passwordController,
      obscureText: true,
    );
  }

  Widget _buildConfirmButton() {
    return ElevatedButton(
        onPressed: () {
          final username = _usernameController.text;
          final password = _passwordController.text;

          // Todo: Validate

          BlocProvider.of<LoginBloc>(context)
              .add(LoginUser(username: username, password: password));
        },
        child: Text(translate(LocaleKeys.general_login)));
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
        onPressed: () {
          context.router.push(const RegisterRoute());
        },
        child: Text(translate(LocaleKeys.general_register)));
  }
}