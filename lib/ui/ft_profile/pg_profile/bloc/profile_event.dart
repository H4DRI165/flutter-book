part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileLoadRequested extends ProfileEvent {
  const ProfileLoadRequested();
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
