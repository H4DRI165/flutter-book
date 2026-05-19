import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../app.dart';

part 'register_event.dart';
part 'state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterPageState> {
  // ------------------------------- CONSTRUCTOR -------------------------------
  RegisterBloc({required this.authRepository}) : super(const RegisterPageState()) {
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<RegisterObscurePasswordToggled>(_onObscurePasswordToggled);
    on<RegisterObscureConfirmPasswordToggled>(_onObscureConfirmPasswordToggled);
    on<RegisterSubmitted>(_onSubmitted);
    on<RegisterGoogleSignIn>(_onGoogleSignIn);
  }

  // --------------------------------- FIELDS ---------------------------------
  final AuthRepository authRepository;

  // --------------------------------- METHODS --------------------------------
  void _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterPageState> emit,
  ) {
    emit(
      state.copyWith(
        email: event.email,
        emailError: null,
        errorMessage: null,
        status: RegisterStatus.initial,
      ),
    );
  }

  void _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterPageState> emit,
  ) {
    emit(
      state.copyWith(
        password: event.password,
        passwordError: null,
        errorMessage: null,
        status: RegisterStatus.initial,
      ),
    );
  }

  void _onConfirmPasswordChanged(
    RegisterConfirmPasswordChanged event,
    Emitter<RegisterPageState> emit,
  ) {
    emit(
      state.copyWith(
        confirmPassword: event.confirmPassword,
        confirmPasswordError: null,
        errorMessage: null,
        status: RegisterStatus.initial,
      ),
    );
  }

  void _onObscurePasswordToggled(
    RegisterObscurePasswordToggled event,
    Emitter<RegisterPageState> emit,
  ) {
    emit(
      state.copyWith(
        obscurePassword: !state.obscurePassword,
        errorMessage: null,
        status: RegisterStatus.initial,
      ),
    );
  }

  void _onObscureConfirmPasswordToggled(
    RegisterObscureConfirmPasswordToggled event,
    Emitter<RegisterPageState> emit,
  ) {
    emit(
      state.copyWith(
        obscureConfirmPassword: !state.obscureConfirmPassword,
        errorMessage: null,
        status: RegisterStatus.initial,
      ),
    );
  }

  Future<void> _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterPageState> emit,
  ) async {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

    final emailError = state.email.isEmpty
        ? 'Email is required.'
        : !emailRegex.hasMatch(state.email)
        ? 'Invalid email address. Please enter a valid email.'
        : null;

    final passwordError = state.password.isEmpty
        ? 'Password is required.'
        : state.password.length < 6
        ? 'Password must be at least 6 characters long.'
        : null;

    final confirmPasswordError = state.confirmPassword.isEmpty
        ? 'Confirm Password is required.'
        : state.confirmPassword != state.password
        ? 'Passwords do not match.'
        : null;

    if (emailError != null || passwordError != null || confirmPasswordError != null) {
      emit(
        state.copyWith(
          emailError: emailError,
          passwordError: passwordError,
          confirmPasswordError: confirmPasswordError,
        ),
      );
      return;
    }

    emit(state.copyWith(status: RegisterStatus.loading));

    try {
      await authRepository.signUp(email: state.email, password: state.password);
      emit(state.copyWith(status: RegisterStatus.success));
    } catch (e) {
      emit(
        state.copyWith(status: RegisterStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _onGoogleSignIn(
    RegisterGoogleSignIn event,
    Emitter<RegisterPageState> emit,
  ) async {
    emit(state.copyWith(status: RegisterStatus.loading));

    try {
      await authRepository.signInWithGoogle();
      emit(state.copyWith(status: RegisterStatus.success));
    } on AuthException catch (e) {
      emit(state.copyWith(status: RegisterStatus.failure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(status: RegisterStatus.failure));
    }
  }
}
