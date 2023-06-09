// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_cubit.dart';

enum SubmissionStatus {
  inProgress,
  idle,
  invalidCredentials,
  timeout,
  networkFailed,
  malformedError,
  clientRequestFailure,
  genericError,
  success,
}

class LoginState {
  LoginState({
    required this.submissionStatus,
    required this.name,
    required this.password,
  });

  factory LoginState.initial() => LoginState(
        submissionStatus: SubmissionStatus.idle,
        name: const Username.unvalidated(),
        password: const Password.unvalidated(),
      );

  final SubmissionStatus submissionStatus;
  final Username name;
  final Password password;

  LoginState copyWith({
    SubmissionStatus? submissionStatus,
    Username? name,
    Password? password,
  }) {
    return LoginState(
      submissionStatus: submissionStatus ?? this.submissionStatus,
      name: name ?? this.name,
      password: password ?? this.password,
    );
  }
}
