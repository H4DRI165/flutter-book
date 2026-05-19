import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'ui/ft_auth/repository/auth_repository.dart';
import 'ui/routes/routes.dart';

final _authRepository = AuthRepository();
final _appRouter = AppRouter(authRepository: _authRepository);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // This is for demo only purpose
  await Supabase.initialize(
    url: 'https://xywelnyzqkxeyeeroewg.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh5d2Vsbnl6cWt4ZXllZXJvZXdnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg3NzA3NTYsImV4cCI6MjA5NDM0Njc1Nn0.qnLX4bTXYndk9EdUs4w1KVf4PR_EI1ZkTLiM5VS5sNI',
  );

  if (Platform.isAndroid || Platform.isIOS) {
    await GoogleSignIn.instance.initialize(
      serverClientId: '951314091908-pbecodmg299bfrsvhhjdtcqc209fsicb.apps.googleusercontent.com',
    );
  }

  runApp(
    RepositoryProvider(
      create: (_) => _authRepository,
      child: const MainApp(),
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
