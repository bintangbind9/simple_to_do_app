import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../common/constants/app_styles.dart';
import '../../../common/exceptions/auth_exceptions.dart';
import '../../../common/utils/dialogs/info_dialog.dart';
import '../../../common/utils/extensions/double_extension.dart';
import '../../../domain/usecases/auth/sign_in_with_email_and_password_use_case.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../widgets/auth/sign_in_with_google_button.dart';
import '../../widgets/common_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isObscureText = true;

  void updateObscureText(bool value) {
    setState(() {
      isObscureText = value;
    });
  }

  void signInWithGoogle(String? idToken) =>
      context.read<AuthBloc>().add(SignInWithGoogle(idToken: idToken));

  void signIn() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(SignInWithEmailAndPassword(
            params: SignInWithEmailAndPasswordParams(
          email: emailController.text,
          password: passwordController.text,
        )));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.exception is UserNotFoundAuthException) {
              showInfoDialog(context, 'User not found');
            } else if (state.exception is UserNotLoggedInAuthException) {
              showInfoDialog(context, 'User not logged in');
            } else if (state.exception is InvalidUserCredentialAuthException) {
              showInfoDialog(context, 'Invalid user credential');
            } else if (state.exception is GenericAuthException) {
              showInfoDialog(context, 'Authentication error');
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sign in'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppStyles.mainPadding),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                CommonTextFormField(
                  controller: emailController,
                  label: 'Email',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'This field is required',
                    ),
                    FormBuilderValidators.email(
                      errorText: 'Invalid email',
                    ),
                  ]),
                  onEditingComplete: signIn,
                ),
                20.0.sizedBoxHeight,
                CommonTextFormField(
                  controller: passwordController,
                  obscureText: isObscureText,
                  label: 'Password',
                  suffixIcon: SuffixIcon(
                    icon: GestureDetector(
                      onTap: () => updateObscureText(!isObscureText),
                      child: Icon(
                        isObscureText
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                        size: 20,
                      ),
                    ),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'This field is required',
                    ),
                  ]),
                  onEditingComplete: signIn,
                ),
                20.0.sizedBoxHeight,
                ElevatedButton(
                  onPressed: signIn,
                  child: Text('Sign in'),
                ),
                20.0.sizedBoxHeight,
                Text(
                  'Or',
                  textAlign: TextAlign.center,
                ),
                20.0.sizedBoxHeight,
                buildSignInWithGoogleButton(
                  context: context,
                  onPressed: () =>
                      context.read<AuthBloc>().add(SignInWithGoogle()),
                ),
                20.0.sizedBoxHeight,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () =>
                          context.read<AuthBloc>().add(RegisteringAccount()),
                      child: Text('Sign up'),
                    ),
                  ],
                ),
                20.0.sizedBoxHeight,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
