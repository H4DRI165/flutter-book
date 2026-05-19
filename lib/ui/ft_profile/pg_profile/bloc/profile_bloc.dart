import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../ft_auth/repository/auth_repository.dart';

part 'profile_event.dart';
part 'state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfilePageState> {
  ProfileBloc({required this.authRepository}) : super(const ProfilePageState()) {
    on<ProfileFullNameChanged>(_onFullNameChanged);
    on<ProfileSavePressed>(_onSavePressed);
    on<ProfileLoadRequested>(_onLoadRequested);
  }

  final AuthRepository authRepository;

  // --------------------------------- METHODS --------------------------------

  void _onFullNameChanged(
    ProfileFullNameChanged event,
    Emitter<ProfilePageState> emit,
  ) {
    emit(state.copyWith(fullName: event.fullName));
  }

  Future<void> _onLoadRequested(
    ProfileLoadRequested event,
    Emitter<ProfilePageState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final user = authRepository.currentUser;
      emit(
        state.copyWith(
          status: ProfileStatus.initial,
          email: user?.email ?? '',
          fullName: user?.userMetadata?['full_name'] ?? '',
          createdAt: user?.createdAt ?? '',
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.failure));
    }
  }

  Future<void> _onSavePressed(
    ProfileSavePressed event,
    Emitter<ProfilePageState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      await authRepository.updateProfile(fullName: state.fullName);
      emit(state.copyWith(status: ProfileStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
