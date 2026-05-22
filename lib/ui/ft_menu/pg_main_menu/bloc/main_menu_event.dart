part of 'main_menu_bloc.dart';

sealed class MainMenuEvent extends Equatable {
  const MainMenuEvent();

  @override
  List<Object?> get props => [];
}

class MainMenuStarted extends MainMenuEvent {
  const MainMenuStarted();
}

class MainMenuLogoutPressed extends MainMenuEvent {
  const MainMenuLogoutPressed();
}

class MainMenuFilterChanged extends MainMenuEvent {
  const MainMenuFilterChanged(this.filter);
  final MainMenuFilter filter;

  @override
  List<Object?> get props => [filter];
}

class MainMenuSearchChanged extends MainMenuEvent {
  const MainMenuSearchChanged(this.query);
  final String query;

  @override
  List<Object?> get props => [query];
}

class MainMenuProgressUpdated extends MainMenuEvent {
  const MainMenuProgressUpdated({
    required this.topicId,
    required this.status,
  });
  final String topicId;
  final ProgressStatus status;

  @override
  List<Object?> get props => [topicId, status];
}
