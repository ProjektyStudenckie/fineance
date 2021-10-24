import 'package:auto_route/auto_route.dart';
import 'package:fineance/components/fineance_button.dart';
import 'package:fineance/components/fineance_text_field.dart';
import 'package:fineance/components/fineance_title.dart';
import 'package:fineance/injection/bloc_factory.dart';
import 'package:fineance/localization/keys.g.dart';
import 'package:fineance/localization/utils.dart';
import 'package:fineance/routing/router.gr.dart';
import 'package:fineance/style/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'bloc/login_bloc.dart';

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
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLoginLabel(),
                const SizedBox(height: Dimens.kMarginLarge),
                _buildUsernameField(),
                _buildPassword(),
                _buildConfirmButton(state.status.isValidated),
                _buildRegisterButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginLabel() {
    return FineanceTitle(text: translate(LocaleKeys.general_login));
  }

  Widget _buildUsernameField() {
    return FineanceTextField(
      label: translate(LocaleKeys.general_username),
      controller: _usernameController,
      onChanged: (username) =>
          context.read<LoginBloc>().add(LoginUsernameChanged(username)),
    );
  }

  Widget _buildPassword() {
    return FineanceTextField(
      label: translate(LocaleKeys.general_password),
      controller: _passwordController,
      obscureText: true,
      onChanged: (password) =>
          context.read<LoginBloc>().add(LoginPasswordChanged(password)),
    );
  }

  Widget _buildConfirmButton(bool isValidated) {
    return FineanceButton(
      text: LocaleKeys.general_login,
      onPressed: () {
        if (isValidated) context.read<LoginBloc>().add(const LoginSubmitted());
      },
    );
  }

  Widget _buildRegisterButton() {
    return FineanceButton.positive(
        onPressed: () {
          context.router.push(const RegisterRoute());
        },
        text: translate(LocaleKeys.general_register));
  }
}
