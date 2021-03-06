import 'package:auto_route/auto_route.dart';
import 'package:fineance/components/fineance_back_button_with_title.dart';
import 'package:fineance/components/fineance_button.dart';
import 'package:fineance/components/fineance_loader.dart';
import 'package:fineance/components/fineance_text_field.dart';
import 'package:fineance/injection/bloc_factory.dart';
import 'package:fineance/localization/keys.g.dart';
import 'package:fineance/localization/utils.dart';
import 'package:fineance/presentation/authorization/register/bloc/register_bloc.dart';
import 'package:fineance/routing/router.gr.dart';
import 'package:fineance/style/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterPage extends StatefulWidget implements AutoRouteWrapper {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    final BlocFactory blocFactory = BlocFactory.of(context);
    return BlocProvider<RegisterBloc>(
      create: (context) => blocFactory.get<RegisterBloc>(),
      child: this,
    );
  }

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();

  final _emailValidator = MultiValidator([
    RequiredValidator(
        errorText: translate(LocaleKeys.validation_email_is_required)),
    EmailValidator(
        errorText: translate(LocaleKeys.validation_email_is_invalid)),
  ]);

  final _usernameValidator = MultiValidator([
    RequiredValidator(
        errorText: translate(LocaleKeys.validation_password_is_required)),
    MinLengthValidator(4,
        errorText: translate(LocaleKeys.validation_username_too_short)),
  ]);

  final _passwordValidator = MultiValidator([
    RequiredValidator(
        errorText: translate(LocaleKeys.validation_password_is_required)),
    MinLengthValidator(4,
        errorText: translate(LocaleKeys.validation_password_too_short)),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: translate(LocaleKeys.validation_password_special))
  ]);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          context.router.replace(const OnboardingRoute());
        } else if (state is RegisterError) {

          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
            content:  Text(translate(LocaleKeys.general_register_failed)),
            duration: const Duration(seconds: 1), ));
        }
      },
      builder: (context, state) {
        if (state is! RegisterLoading) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    FineanceBackButtonWithTitle(
                        key: const ValueKey("registerTitle"),
                        text: translate(LocaleKeys.general_register)),
                    const SizedBox(height: Dimens.kMarginLarge),
                    _buildEmailField(),
                    _buildUsernameField(),
                    _buildPasswordField(),
                    _buildPasswordConfirmationField(),
                    _buildConfirmButton(),
                  ],
                ),
              ),
            ),
          ),
        );
      }
        return const Scaffold(body: Center(child: FineanceLoader()));},
    );
  }

  Widget _buildEmailField() {
    return FineanceTextField(
      key: const ValueKey("emailInput"),
      label: translate(LocaleKeys.general_email),
      controller: _emailController,
      validator: _emailValidator,
      textInputAction: TextInputAction.next,
    );
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

  Widget _buildPasswordField() {
    return FineanceTextField(
      key: const ValueKey("passwordInput"),
      label: translate(LocaleKeys.general_password),
      controller: _passwordController,
      validator: _passwordValidator,
      textInputAction: TextInputAction.next,
      obscureText: true,
    );
  }

  Widget _buildPasswordConfirmationField() {
    return FineanceTextField(
      key: const ValueKey("passwordConfirmationInput"),
      label: translate(LocaleKeys.general_confirm_password),
      controller: _passwordConfirmationController,
      obscureText: true,
      validator: (val) => MatchValidator(
              errorText:
                  translate(LocaleKeys.validation_passwords_do_not_match))
          .validateMatch(val ?? "", _passwordController.text),
    );
  }

  Widget _buildConfirmButton() {
    return FineanceButton(
        key: const ValueKey("registerButton"),
        onPressed: () {
          final email = _emailController.text;
          final username = _usernameController.text;
          final password = _passwordController.text;

          if (_formKey.currentState?.validate() == true) {
            BlocProvider.of<RegisterBloc>(context).add(RegisterUser(
                email: email, username: username, password: password));
          }
        },
        text: translate(LocaleKeys.general_register));
  }
}
