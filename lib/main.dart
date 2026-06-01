import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'ui/ft_auth/repository/auth_repository.dart';
import 'ui/ft_menu/pg_main_menu/bloc/main_menu_bloc.dart';
import 'ui/ft_menu/pg_main_menu/repository/main_menu_repository.dart';
import 'ui/routes/routes.dart';

late final AuthRepository _authRepository;
late final MainMenuBloc _mainMenuBloc;
late final AppRouter _appRouter;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  _authRepository = AuthRepository();
  _mainMenuBloc = MainMenuBloc(
    authRepository: _authRepository,
    mainMenuRepository: MainMenuRepository(),
  );
  _appRouter = AppRouter(authRepository: _authRepository);

  if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS)) {
    await GoogleSignIn.instance.initialize(
      serverClientId: dotenv.env['GOOGLE_CLIENT_ID']!,
    );
  }

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => _authRepository),
      ],
      child: BlocProvider.value(
        value: _mainMenuBloc,
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ).copyWith(surface: const Color(0xFF30302E)),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ).copyWith(surface: const Color(0xFF30302E)),
      ),
      themeMode: ThemeMode.system,
    );
  }
}
