// class RegisterPage extends StatefulWidget implements AutoRouteWrapper {
//   const RegisterPage({Key? key}) : super(key: key);
//
//   @override
//   Widget wrappedRoute(BuildContext context) {
//     final BlocFactory blocFactory = BlocFactory.of(context);
//     return BlocProvider<RegisterBloc>(
//       create: (context) => blocFactory.get<RegisterBloc>(),
//       child: this,
//     );
//   }
//
//   @override
//   _RegisterPageState createState() => _RegisterPageState();
// }
//
// class _RegisterPageState extends State<RegisterPage> {
//   final _emailController = TextEditingController();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _passwordConfirmationController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<RegisterBloc, RegisterState>(
//       listener: (context, state) {
//         if (state is RegisterSuccess) {
//           context.router.replace(const OnboardingRoute());
//         } else if (state is RegisterError) {
//           // TODO: Display error to the user
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           body: SafeArea(
//             child: Column(
//               children: [
//                 FineanceBackButtonWithTitle(
//                     text: translate(LocaleKeys.general_register)),
//                 const SizedBox(height: Dimens.kMarginLarge),
//                 _buildEmailField(),
//                 _buildUsernameField(),
//                 _buildPasswordField(),
//                 _buildPasswordConfirmationField(),
//                 _buildConfirmButton(),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildEmailField() {
//     return FineanceTextField(
//       label: translate(LocaleKeys.general_email),
//       controller: _emailController,
//     );
//   }
//
//   Widget _buildUsernameField() {
//     return FineanceTextField(
//       label: translate(LocaleKeys.general_username),
//       controller: _usernameController,
//     );
//   }
//
//   Widget _buildPasswordField() {
//     return FineanceTextField(
//       label: translate(LocaleKeys.general_password),
//       controller: _passwordController,
//       obscureText: true,
//     );
//   }
//
//   Widget _buildPasswordConfirmationField() {
//     return FineanceTextField(
//       label: translate(LocaleKeys.general_confirm_password),
//       controller: _passwordConfirmationController,
//       obscureText: true,
//     );
//   }
//
//   Widget _buildConfirmButton() {
//     return FineanceButton(
//         onPressed: () {
//           final email = _emailController.text;
//           final username = _usernameController.text;
//           final password = _passwordController.text;
//
//           // Todo: Validate
//
//           BlocProvider.of<RegisterBloc>(context).add(RegisterUser(
//               email: email, username: username, password: password));
//         },
//         text: translate(LocaleKeys.general_register));
//   }
// }
