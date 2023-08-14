import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:papa_burger_admin_panel/src/models/form_fields/password.dart';
import 'package:papa_burger_admin_panel/src/models/form_fields/username.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState.initial());

  void onUsernameChanged(String newValue) {
    final previousScreenState = state;
    final previousUsernameState = previousScreenState.name;
    final shouldValidate = previousUsernameState.invalid;
    final newUsernameState = shouldValidate
        ? Username.validated(
            newValue,
          )
        : Username.unvalidated(
            newValue,
          );

    final newScreenState = state.copyWith(
      name: newUsernameState,
    );

    emit(newScreenState);
  }

  void onUsernameUnfocused() {
    final previousScreenState = state;
    final previousUsernameState = previousScreenState.name;
    final previousUsernameValue = previousUsernameState.value;

    final newUsernameState = Username.validated(
      previousUsernameValue,
    );
    final newScreenState = previousScreenState.copyWith(
      name: newUsernameState,
    );
    emit(newScreenState);
  }

  void onPasswordChanged(String newValue) {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.password;
    final shouldValidate = previousPasswordState.invalid;
    final newPasswordState = shouldValidate
        ? Password.validated(
            newValue,
          )
        : Password.unvalidated(
            newValue,
          );

    final newScreenState = state.copyWith(
      password: newPasswordState,
    );

    emit(newScreenState);
  }

  void onPasswordUnfocused() {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.password;
    final previousPasswordValue = previousPasswordState.value;

    final newPasswordState = Password.validated(
      previousPasswordValue,
    );
    final newScreenState = previousScreenState.copyWith(
      password: newPasswordState,
    );
    emit(newScreenState);
  }

  void onLogOut() {
    const name = Username.unvalidated();
    const password = Password.unvalidated();
    final newState = state.copyWith(
      name: name,
      password: password,
      submissionStatus: SubmissionStatus.idle,
    );
    emit(newState);
  }

  Future<void> onSubmit() async {
    final name = Username.validated(state.name.value);
    final password = Password.validated(state.password.value);
    final isFormValid = Formz.validate([name, password]).isValid;

    final newState = state.copyWith(
      name: name,
      password: password,
      submissionStatus: isFormValid ? SubmissionStatus.inProgress : null,
    );

    emit(newState);

    if (isFormValid) {
      if (name.value == 'admin' && password.value == 'admin') {
        final newState = state.copyWith(
          submissionStatus: SubmissionStatus.success,
        );
        Future<void>.delayed(const Duration(seconds: 1), () {
          emit(newState);
        });
      } else {
        final newState = state.copyWith(
          submissionStatus: SubmissionStatus.invalidCredentials,
        );
        emit(newState);
      }
    }
  }
}
