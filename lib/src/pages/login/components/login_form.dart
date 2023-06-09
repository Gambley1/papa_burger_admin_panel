import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papa_burger_admin_panel/src/config/constants/padding.dart';
import 'package:papa_burger_admin_panel/src/config/extensions/navigator_extension.dart';
import 'package:papa_burger_admin_panel/src/config/extensions/snack_bar_extension.dart';
import 'package:papa_burger_admin_panel/src/models/form_fields/password.dart';
import 'package:papa_burger_admin_panel/src/models/form_fields/username.dart';
import 'package:papa_burger_admin_panel/src/pages/login/state/login_cubit.dart';
import 'package:papa_burger_admin_panel/src/widgets/custom_form_field.dart';
import 'package:papa_burger_admin_panel/src/widgets/k_text.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<LoginCubit>();
    _usernameFocusNode.addListener(() {
      if (!_usernameFocusNode.hasFocus) {
        cubit.onUsernameUnfocused();
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        cubit.onPasswordUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return BlocConsumer<LoginCubit, LoginState>(
      listenWhen: (p, c) => p.submissionStatus != c.submissionStatus,
      listener: (context, state) {
        final status = state.submissionStatus;
        final success = status == SubmissionStatus.success;
        final invalidCredentials =
            status == SubmissionStatus.invalidCredentials;
        if (success) {
          context
            ..showSnackBar('Successfuly logged into account!')
            ..navigateToMainPage();
        }
        if (invalidCredentials) {
          context.showSnackBar('Invalid username and/or password');
        }
      },
      builder: (context, state) {
        final status = state.submissionStatus;
        final loading = status == SubmissionStatus.inProgress;
        final nameError = state.name.invalid ? state.name.error : null;
        final passwordError =
            state.password.invalid ? state.password.error : null;
        final cubit = context.read<LoginCubit>();
        return LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final bigScreen = maxWidth >= 600;
            return Column(
              children: [
                SizedBox(
                  width: bigScreen ? width * 0.2 : width * 0.5,
                  child: CustomFormField(
                    focusNode: _usernameFocusNode,
                    onChanged: cubit.onUsernameChanged,
                    hintText: 'e.g Emil',
                    labelText: 'Username',
                    floatingLabelBehaviour: FloatingLabelBehavior.auto,
                    enabled: !loading,
                    textInputAction: TextInputAction.next,
                    contentPadding:
                        const EdgeInsets.only(bottom: bottomPadding - 6),
                    errorText: nameError == null
                        ? null
                        : (nameError == UsernameValidationError.empty
                            ? 'Username is required'
                            : 'Invalid username'),
                  ),
                ),
                SizedBox(
                  width: bigScreen ? width * 0.2 : width * 0.5,
                  child: CustomFormField(
                    focusNode: _passwordFocusNode,
                    onChanged: cubit.onPasswordChanged,
                    hintText: 'e.g 12345',
                    labelText: 'Password',
                    floatingLabelBehaviour: FloatingLabelBehavior.auto,
                    enabled: !loading,
                    textInputAction: TextInputAction.done,
                    contentPadding:
                        const EdgeInsets.only(bottom: bottomPadding - 6),
                    errorText: passwordError == null
                        ? null
                        : (passwordError == PasswordValidationError.empty
                            ? 'Password is required'
                            : 'Invalid password'),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                LoginButton(status: status, login: cubit.onSubmit),
              ],
            );
          },
        );
      },
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    required this.status,
    required this.login,
    super.key,
  });

  final SubmissionStatus status;
  final void Function()? login;

  @override
  Widget build(BuildContext context) {
    if (status == SubmissionStatus.inProgress) {
      return ElevatedButton.icon(
        onPressed: () {},
        style: const ButtonStyle(
          minimumSize: MaterialStatePropertyAll(Size(150, 40)),
        ),
        icon: Transform.scale(
          scale: 0.5,
          child: const CircularProgressIndicator(
            color: Colors.black,
          ),
        ),
        label: const KText(''),
      );
    }
    return ElevatedButton(
      onPressed: login,
      style: const ButtonStyle(
        minimumSize: MaterialStatePropertyAll(Size(150, 40)),
      ),
      child: const KText(
        'Login',
        color: Colors.white,
        size: 20,
      ),
    );
  }
}
