part of 'forgot_password_bloc.dart';

enum Status { initial, loading, success, failure }

class ForgotPasswordPageState extends Equatable {
  const ForgotPasswordPageState({
    this.status = Status.initial,
    this.email = '',
    this.emailError,
    this.errorMessage,
  });

  final Status status;
  final String email;
  final String? emailError;
  final String? errorMessage;

  ForgotPasswordPageState copyWith({
    Status? status,
    String? email,
    String? emailError,
    String? errorMessage,
  }) {
    return ForgotPasswordPageState(
      status: status ?? this.status,
      email: email ?? this.email,
      emailError: emailError,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    email,
    emailError,
    errorMessage,
  ];
}
