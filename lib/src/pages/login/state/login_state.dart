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
  const LoginState._({
    this.submissionStatus = SubmissionStatus.idle,
    this.name = const Username.unvalidated(),
    this.password = const Password.unvalidated(),
  });

  const LoginState.initial() : this._();

  final SubmissionStatus submissionStatus;
  final Username name;
  final Password password;

  LoginState copyWith({
    SubmissionStatus? submissionStatus,
    Username? name,
    Password? password,
  }) {
    return LoginState._(
      submissionStatus: submissionStatus ?? this.submissionStatus,
      name: name ?? this.name,
      password: password ?? this.password,
    );
  }
}
