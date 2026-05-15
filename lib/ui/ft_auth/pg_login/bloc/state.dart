part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginPageState extends Equatable {
  const LoginPageState({
    this.status = LoginStatus.initial,
    this.email = '',
    this.password = '',
    this.obscurePassword = true,
    this.emailError,
    this.passwordError,
    this.errorMessage,
  });

  final LoginStatus status;
  final String email;
  final String password;
  final bool obscurePassword;
  final String? emailError;
  final String? passwordError;
  final String? errorMessage;

  LoginPageState copyWith({
    LoginStatus? status,
    String? email,
    String? password,
    bool? obscurePassword,
    String? emailError,
    String? passwordError,
    String? errorMessage,
  }) {
    return LoginPageState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      emailError: emailError,
      passwordError: passwordError,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    email,
    password,
    obscurePassword,
    emailError,
    passwordError,
    errorMessage,
  ];
}
