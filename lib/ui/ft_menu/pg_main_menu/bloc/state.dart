part of 'main_menu_bloc.dart';

enum MainMenuStatus { initial, loading, loggedOut, failure }

class MainMenuState extends Equatable {
  const MainMenuState({
    this.status = MainMenuStatus.initial,
  });

  final MainMenuStatus status;

  MainMenuState copyWith({MainMenuStatus? status}) {
    return MainMenuState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}