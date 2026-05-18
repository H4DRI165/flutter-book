part of 'register_bloc.dart';

enum RegisterStatus { initial, loading, success, failure }

class RegisterPageState extends Equatable {
  const RegisterPageState({
    this.status = RegisterStatus.initial,
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
    this.errorMessage,
  });

  final RegisterStatus status;
  final String email;
  final String password;
  final String confirmPassword;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;
  final String? errorMessage;

  RegisterPageState copyWith({
    RegisterStatus? status,
    String? email,
    String? password,
    String? confirmPassword,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    String? errorMessage,
  }) {
    return RegisterPageState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
      emailError: emailError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        email,
        password,
        confirmPassword,
        obscurePassword,
        obscureConfirmPassword,
        emailError,
        passwordError,
        confirmPasswordError,
        errorMessage,
      ];
}