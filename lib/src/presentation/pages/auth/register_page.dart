import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../common/constants/app_styles.dart';
import '../../../common/exceptions/auth_exceptions.dart';
import '../../../common/utils/dialogs/info_dialog.dart';
import '../../../common/utils/extensions/double_extension.dart';
import '../../../common/utils/validator_util.dart';
import '../../../domain/usecases/auth/create_user_with_email_and_password_use_case.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/equal_password_validation/equal_password_validation_bloc.dart';
import '../../widgets/common_text_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.exception is UserNotLoggedInAuthException) {
          showInfoDialog(context, 'User not logged in');
        } else if (state.exception is WeakPasswordAuthException) {
          showInfoDialog(context, 'Weak password');
        } else if (state.exception is EmailAlreadyInUseAuthException) {
          showInfoDialog(context, 'Email already in use');
        } else if (state.exception is InvalidEmailAuthException) {
          showInfoDialog(context, 'Invalid email');
        } else if (state.exception is GenericAuthException) {
          showInfoDialog(context, 'Authentication error');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sign up'),
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
                ),
                20.0.sizedBoxHeight,
                CommonTextFormField(
                  controller: passwordController,
                  obscureText: true,
                  label: 'Password',
                  onChanged: (text) => context
                      .read<EqualPasswordValidationBloc>()
                      .add(UpdateEqualPasswordValidation(password: text)),
                  validator: ValidatorUtil.passwordValidator(context),
                ),
                20.0.sizedBoxHeight,
                BlocBuilder<EqualPasswordValidationBloc, String>(
                  buildWhen: (prev, curr) => prev != curr,
                  builder: (context, password) {
                    return CommonTextFormField(
                      controller: rePasswordController,
                      obscureText: true,
                      label: 'Re-enter password',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.equal(
                          password,
                          errorText: 'Passwords do not match',
                        ),
                      ]),
                    );
                  },
                ),
                20.0.sizedBoxHeight,
                ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;

                    context.read<AuthBloc>().add(CreateUserWithEmailAndPassword(
                            params: CreateUserWithEmailAndPasswordParams(
                          email: emailController.text,
                          password: passwordController.text,
                        )));
                  },
                  child: Text('Sign up'),
                ),
                20.0.sizedBoxHeight,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    TextButton(
                      onPressed: () => context.read<AuthBloc>().add(SignOut()),
                      child: Text('Sign in'),
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
