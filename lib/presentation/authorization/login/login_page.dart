import 'package:auto_route/auto_route.dart';
import 'package:fineance/components/fineance_button.dart';
import 'package:fineance/components/fineance_text_field.dart';
import 'package:fineance/extension/context_extension.dart';
import 'package:fineance/injection/bloc_factory.dart';
import 'package:fineance/localization/keys.g.dart';
import 'package:fineance/localization/utils.dart';
import 'package:fineance/presentation/authorization/login/bloc/login_bloc.dart';
import 'package:fineance/routing/router.gr.dart';
import 'package:fineance/style/colors.dart';
import 'package:fineance/style/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget implements AutoRouteWrapper {
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
                const SizedBox(height: Constants.kMarginLarge),
                _buildLoginLabel(),
                const SizedBox(height: Constants.kMarginLarge),
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

  Widget _buildLoginLabel() {
    return Text(
      translate(LocaleKeys.general_login),
      style: context.typo.extraLargeBold(),
    );
  }

  Widget _buildUsernameField() {
    return FineanceTextField(
      label: translate(LocaleKeys.general_username),
      controller: _usernameController,
    );
  }

  Widget _buildPassword() {
    return FineanceTextField(
        label: translate(LocaleKeys.general_password), controller: _passwordController, obscureText: true);
  }

  Widget _buildConfirmButton() {
    return FineanceButton(
        onPressed: () {
          final username = _usernameController.text;
          final password = _passwordController.text;

          // Todo: Validate

          BlocProvider.of<LoginBloc>(context)
              .add(LoginUser(username: username, password: password));
        },
        text: translate(LocaleKeys.general_login));
  }

  Widget _buildRegisterButton() {
    return FineanceButton(
        color: AppColors.green,
        onPressed: () {
          context.router.push(const RegisterRoute());
        },
        text: translate(LocaleKeys.general_register));
  }
}
