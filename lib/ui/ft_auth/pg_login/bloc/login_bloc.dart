import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../app.dart';

part 'login_event.dart';
part 'state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginPageState> {
  // ------------------------------- CONSTRUCTOR -------------------------------
  LoginBloc({required this.authRepository}) : super(const LoginPageState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginObscurePasswordToggled>(_onObscurePasswordToggled);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginGoogleSignIn>(_onGoogleSignIn);
  }

  // --------------------------------- FIELDS ---------------------------------
  final AuthRepository authRepository;

  // --------------------------------- METHODS --------------------------------
  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginPageState> emit,
  ) {
    emit(
      state.copyWith(
        email: event.email,
        emailError: null,
        errorMessage: null,
        status: LoginStatus.initial,
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginPageState> emit,
  ) {
    emit(
      state.copyWith(
        password: event.password,
        passwordError: null,
        errorMessage: null,
        status: LoginStatus.initial,
      ),
    );
  }

  void _onObscurePasswordToggled(
    LoginObscurePasswordToggled event,
    Emitter<LoginPageState> emit,
  ) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginPageState> emit,
  ) async {
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

    final emailError = state.email.isEmpty
        ? 'Email is required.'
        : !emailRegex.hasMatch(state.email)
        ? 'Invalid email address. Please enter a valid email.'
        : null;

    final passwordError = state.password.isEmpty ? 'Password is required.' : null;

    if (emailError != null || passwordError != null) {
      emit(
        state.copyWith(
          status: LoginStatus.initial,
          emailError: emailError,
          passwordError: passwordError,
          errorMessage: null,
        ),
      );
      return;
    }

    emit(state.copyWith(status: LoginStatus.loading));

    try {
      await authRepository.signIn(email: state.email, password: state.password);
      emit(state.copyWith(status: LoginStatus.success));
    } on AuthException catch (e) {
      emit(state.copyWith(status: LoginStatus.failure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.failure));
    }
  }

  Future<void> _onGoogleSignIn(
    LoginGoogleSignIn event,
    Emitter<LoginPageState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      await authRepository.signInWithGoogle();
      emit(state.copyWith(status: LoginStatus.success));
    } on AuthException catch (e) {
      emit(state.copyWith(status: LoginStatus.failure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.failure));
    }
  }
}
