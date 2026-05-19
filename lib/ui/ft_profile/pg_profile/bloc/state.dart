part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfilePageState extends Equatable {
  const ProfilePageState({
    this.status = ProfileStatus.initial,
    this.fullName = '',
    this.email = '',
    this.avatarUrl,
    this.pickedImage,
    this.errorMessage,
  });

  final ProfileStatus status;
  final String fullName;
  final String email;
  final String? avatarUrl;
  final File? pickedImage;
  final String? errorMessage;

  ProfilePageState copyWith({
    ProfileStatus? status,
    String? fullName,
    String? email,
    String? avatarUrl,
    File? pickedImage,
    String? errorMessage,
  }) {
    return ProfilePageState(
      status: status ?? this.status,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      pickedImage: pickedImage ?? this.pickedImage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, fullName, email, avatarUrl, pickedImage, errorMessage];
}
