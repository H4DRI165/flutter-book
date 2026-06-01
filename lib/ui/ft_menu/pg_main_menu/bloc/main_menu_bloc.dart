import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../app.dart';
import '../repository/main_menu_repository.dart';

part 'main_menu_event.dart';
part 'state.dart';

class MainMenuBloc extends Bloc<MainMenuEvent, MainMenuPageState> {
  MainMenuBloc({
    required this.authRepository,
    required this.mainMenuRepository,
  }) : super(const MainMenuPageState()) {
    on<MainMenuStarted>(_onStarted);
    on<MainMenuLogoutPressed>(_onLogoutPressed);
    on<MainMenuFilterChanged>(_onFilterChanged);
    on<MainMenuSearchChanged>(_onSearchChanged);
    on<MainMenuProgressUpdated>(_onProgressUpdated);
    on<MainMenuRefreshDisplayName>(_onRefreshDisplayName);
  }

  final AuthRepository authRepository;
  final MainMenuRepository mainMenuRepository;

  void _onRefreshDisplayName(
    MainMenuRefreshDisplayName event,
    Emitter<MainMenuPageState> emit,
  ) {
    final displayName = mainMenuRepository.getDisplayName();
    emit(state.copyWith(displayName: displayName));
  }

  Future<void> _onStarted(
    MainMenuStarted event,
    Emitter<MainMenuPageState> emit,
  ) async {
    emit(state.copyWith(status: MainMenuStatus.loading));
    try {
      final topics = await mainMenuRepository.fetchTopics();
      final progress = await mainMenuRepository.fetchUserProgress();
      final displayName = mainMenuRepository.getDisplayName();
      emit(
        state.copyWith(
          status: MainMenuStatus.success,
          topics: topics,
          userProgress: progress,
          displayName: displayName,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: MainMenuStatus.loadingFailure));
    }
  }

  Future<void> _onLogoutPressed(
    MainMenuLogoutPressed event,
    Emitter<MainMenuPageState> emit,
  ) async {
    emit(state.copyWith(status: MainMenuStatus.loading));
    try {
      await authRepository.signOut();
      emit(state.copyWith(status: MainMenuStatus.loggedOut));
    } catch (e) {
      emit(state.copyWith(status: MainMenuStatus.failure));
    }
  }

  void _onFilterChanged(
    MainMenuFilterChanged event,
    Emitter<MainMenuPageState> emit,
  ) {
    emit(state.copyWith(filter: event.filter));
  }

  void _onSearchChanged(
    MainMenuSearchChanged event,
    Emitter<MainMenuPageState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query));
  }

  Future<void> _onProgressUpdated(
    MainMenuProgressUpdated event,
    Emitter<MainMenuPageState> emit,
  ) async {
    try {
      await mainMenuRepository.updateProgress(
        topicId: event.topicId,
        status: event.status,
      );

      final progress = await mainMenuRepository.fetchUserProgress();
      emit(state.copyWith(userProgress: progress));
    } catch (e) {
      emit(state.copyWith(status: MainMenuStatus.progressUpdateFailure));
    }
  }
}
