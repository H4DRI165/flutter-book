import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../app.dart';

part 'forgot_password_event.dart';
part 'state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordPageState> {
  // ------------------------------- CONSTRUCTOR -------------------------------
  ForgotPasswordBloc({required this.authRepository})
    : super(
        const ForgotPasswordPageState(),
      ) {
    on<ForgotPasswordEmailChanged>(_onEmailChanged);
    on<ForgotPasswordSubmitted>(_onSubmitted);
  }

  // --------------------------------- FIELDS ---------------------------------
  final AuthRepository authRepository;

  // --------------------------------- METHODS --------------------------------
  void _onEmailChanged(
    ForgotPasswordEmailChanged event,
    Emitter<ForgotPasswordPageState> emit,
  ) {
    emit(state.copyWith(email: event.email, emailError: null));
  }

  Future<void> _onSubmitted(
    ForgotPasswordSubmitted event,
    Emitter<ForgotPasswordPageState> emit,
  ) async {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    final emailError = state.email.isEmpty
        ? 'Email is required.'
        : !emailRegex.hasMatch(state.email)
        ? 'Invalid email address. Please enter a valid email.'
        : null;

    if (emailError != null) {
      emit(state.copyWith(emailError: emailError));
      return;
    }

    emit(state.copyWith(status: Status.loading));

    try {
      await authRepository.requestPasswordReset(state.email);
      emit(state.copyWith(status: Status.success));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, errorMessage: e.toString()));
    }
  }
}
