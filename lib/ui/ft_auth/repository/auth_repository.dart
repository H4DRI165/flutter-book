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

  Future<void> updateProfile({required String fullName}) async {
    await _supabase.auth.updateUser(
      UserAttributes(
        data: {'full_name': fullName},
      ),
    );
  }

  Future<String> uploadAvatar(File imageFile) async {
    final userId = currentUser!.id;
    final path = '$userId/avatar.jpg';

    await _supabase.storage
        .from('avatars')
        .upload(
          path,
          imageFile,
          fileOptions: const FileOptions(upsert: true),
        );

    final url = _supabase.storage.from('avatars').getPublicUrl(path);

    // save url to user metadata
    await _supabase.auth.updateUser(
      UserAttributes(data: {'avatar_url': url}),
    );

    return url;
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  User? get currentUser => _supabase.auth.currentUser;
  bool get isLoggedIn => currentUser != null;
}
