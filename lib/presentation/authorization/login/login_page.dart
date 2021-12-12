import 'package:auto_route/auto_route.dart';
import 'package:fineance/components/fineance_button.dart';
import 'package:fineance/components/fineance_loader.dart';
import 'package:fineance/components/fineance_text_field.dart';
import 'package:fineance/components/fineance_title.dart';
import 'package:fineance/injection/bloc_factory.dart';
import 'package:fineance/localization/keys.g.dart';
import 'package:fineance/localization/utils.dart';
import 'package:fineance/presentation/authorization/login/bloc/login_bloc.dart';
import 'package:fineance/routing/router.gr.dart';
import 'package:fineance/style/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

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
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _usernameValidator = RequiredValidator(
      errorText: translate(LocaleKeys.validation_username_is_required));

  final _passwordValidator = RequiredValidator(
      errorText: translate(LocaleKeys.validation_password_is_required));

  @override
  void initState() {
    BlocProvider.of<LoginBloc>(context).add(TryLoginOnStart());
    super.initState();
  }

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
          Scaffold.of(context).showSnackBar(SnackBar(
            content:  Text(translate(LocaleKeys.general_failed)),
            duration: const Duration(seconds: 1),
            action: SnackBarAction(
              label: 'ACTION',
              onPressed: () { },
            ),
          ));
        }
      },
      builder: (context, state) {
        if (state is LoginIncorrect) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLoginLabel(),
                      const SizedBox(height: Dimens.kMarginLarge),
                      _buildUsernameField(),
                      _buildPassword(),
                      _buildConfirmButton(),
                      _buildRegisterButton(),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return const Scaffold(body: Center(child: FineanceLoader()));
      },
    );
  }

  Widget _buildLoginLabel() {
    return FineanceTitle(
        key: const ValueKey("loginTitle"),
        text: translate(LocaleKeys.general_login));
  }

  Widget _buildUsernameField() {
    return FineanceTextField(
      key: const ValueKey("usernameInput"),
      label: translate(LocaleKeys.general_username),
      controller: _usernameController,
      validator: _usernameValidator,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildPassword() {
    return FineanceTextField(
        key: const ValueKey("passwordInput"),
        label: translate(LocaleKeys.general_password),
        controller: _passwordController,
        obscureText: true,
        validator: _passwordValidator);
  }

  Widget _buildConfirmButton() {
    return FineanceButton(
        key: const ValueKey("loginButton"),
        onPressed: () {
          final username = _usernameController.text;
          final password = _passwordController.text;

          if (_formKey.currentState?.validate() == true) {
            BlocProvider.of<LoginBloc>(context)
                .add(LoginUser(username: username, password: password));
          }
        },
        text: translate(LocaleKeys.general_login));
  }

  Widget _buildRegisterButton() {
    return FineanceButton.positive(
        key: const ValueKey("registerButton"),
        onPressed: () {
          context.router.push(const RegisterRoute());
        },
        text: translate(LocaleKeys.general_register));
  }
}
