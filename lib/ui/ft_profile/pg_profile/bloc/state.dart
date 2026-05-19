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

  static const _unset = Object();
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
    Object? avatarUrl = _unset,
    Object? pickedImage = _unset,
    Object? errorMessage = _unset,
  }) {
    return ProfilePageState(
      status: status ?? this.status,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      avatarUrl: identical(avatarUrl, _unset) ? this.avatarUrl : avatarUrl as String?,
      pickedImage: identical(pickedImage, _unset) ? this.pickedImage : pickedImage as File?,
      errorMessage: identical(errorMessage, _unset) ? this.errorMessage : errorMessage as String?,
    );
  }

  @override
  List<Object?> get props => [status, fullName, email, avatarUrl, pickedImage, errorMessage];
}
