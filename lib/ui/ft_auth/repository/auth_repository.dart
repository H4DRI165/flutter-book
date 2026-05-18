import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final _supabase = Supabase.instance.client;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signInWithGoogle() async {
    if (!Platform.isAndroid && !Platform.isIOS) {
      throw UnsupportedError('Google Sign In is not supported on this platform.');
    }

    const scopes = ['email', 'profile'];

    final googleUser = await GoogleSignIn.instance.authenticate();

    final authorization =
        await googleUser.authorizationClient.authorizationForScopes(scopes) ??
        await googleUser.authorizationClient.authorizeScopes(scopes);

    final idToken = googleUser.authentication.idToken;

    if (idToken == null) {
      throw const AuthException('No ID Token found.');
    }

    await _supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: authorization.accessToken,
    );
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    await _supabase.auth.signUp(
      email: email,
      password: password,
    );
  }

  Future<void> requestPasswordReset(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  User? get currentUser => _supabase.auth.currentUser;
  bool get isLoggedIn => currentUser != null;
}
