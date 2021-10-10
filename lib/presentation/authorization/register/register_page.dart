import 'package:auto_route/auto_route.dart';
import 'package:fineance/injection/bloc_factory.dart';
import 'package:fineance/localization/keys.g.dart';
import 'package:fineance/localization/utils.dart';
import 'package:fineance/presentation/authorization/register/bloc/register_bloc.dart';
import 'package:fineance/routing/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          context.router.replace(const OnboardingRoute());
        } else if (state is RegisterError) {
          // TODO: Display error to the user
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                _buildBackButton(),
                _buildEmailField(),
                _buildUsernameField(),
                _buildPasswordField(),
                _buildPasswordConfirmationField(),
                _buildConfirmButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBackButton() {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        context.router.pop();
      },
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
    );
  }

  Widget _buildUsernameField() {
    return TextField(
      controller: _usernameController,
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: true,
    );
  }

  Widget _buildPasswordConfirmationField() {
    return TextField(
      controller: _passwordController,
      obscureText: true,
    );
  }

  Widget _buildConfirmButton() {
    return ElevatedButton(
        onPressed: () {
          final email = _emailController.text;
          final username = _usernameController.text;
          final password = _passwordController.text;

          // Todo: Validate

          BlocProvider.of<RegisterBloc>(context).add(RegisterUser(
              email: email, username: username, password: password));
        },
        child: Text(translate(LocaleKeys.general_register)));
  }
}
