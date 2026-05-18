import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../ft_auth/repository/auth_repository.dart';

part 'main_menu_event.dart';
part 'state.dart';

class MainMenuBloc extends Bloc<MainMenuEvent, MainMenuState> {
  MainMenuBloc({required this.authRepository}) : super(const MainMenuState()) {
    on<MainMenuLogoutPressed>(_onLogoutPressed);
  }

  final AuthRepository authRepository;

  Future<void> _onLogoutPressed(
    MainMenuLogoutPressed event,
    Emitter<MainMenuState> emit,
  ) async {
    emit(state.copyWith(status: MainMenuStatus.loading));
    try {
      await authRepository.signOut();
      emit(state.copyWith(status: MainMenuStatus.loggedOut));
    } catch (e) {
      emit(state.copyWith(status: MainMenuStatus.failure));
    }
  }
}