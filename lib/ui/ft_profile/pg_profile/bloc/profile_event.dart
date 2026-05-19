part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileLoadRequested extends ProfileEvent {
  const ProfileLoadRequested();
}

class ProfileImagePicked extends ProfileEvent {
  const ProfileImagePicked(this.imageFile);
  final File imageFile;

  @override
  List<Object?> get props => [imageFile];
}

class ProfileImageConfirmed extends ProfileEvent {
  const ProfileImageConfirmed();
}

class ProfileFullNameChanged extends ProfileEvent {
  const ProfileFullNameChanged(this.fullName);
  final String fullName;

  @override
  List<Object?> get props => [fullName];
}

class ProfileSavePressed extends ProfileEvent {
  const ProfileSavePressed();
}
