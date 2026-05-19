part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfilePageState extends Equatable {
  const ProfilePageState({
    this.status = ProfileStatus.initial,
    this.fullName = '',
    this.email = '',
    this.createdAt = '',
    this.errorMessage,
  });

  final ProfileStatus status;
  final String fullName;
  final String email;
  final String createdAt;
  final String? errorMessage;

  ProfilePageState copyWith({
    ProfileStatus? status,
    String? fullName,
    String? email,
    String? createdAt,
    String? errorMessage,
  }) {
    return ProfilePageState(
      status: status ?? this.status,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, fullName, email, createdAt, errorMessage];
}
