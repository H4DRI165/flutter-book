import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../app.dart';

class MainMenuRepository {
  MainMenuRepository({SupabaseClient? supabase}) : _supabase = supabase ?? Supabase.instance.client;

  final SupabaseClient _supabase;

  Future<List<Topic>> fetchTopics() async {
    final response = await _supabase.from('topics').select().order('order_index', ascending: true);

    return (response as List).map((json) => Topic.fromJson(json as Map<String, dynamic>)).toList();
  }

  Future<List<UserProgress>> fetchUserProgress() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return [];

    final response = await _supabase.from('user_progress').select().eq('user_id', userId);

    return (response as List).map((json) => UserProgress.fromJson(json as Map<String, dynamic>)).toList();
  }

  Future<void> updateProgress({
    required String topicId,
    required ProgressStatus status,
  }) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    await _supabase.from('user_progress').upsert(
      {
        'user_id': userId,
        'topic_id': topicId,
        'status': status.value,
        'updated_at': DateTime.now().toIso8601String(),
      },
      onConflict: 'user_id, topic_id',
    );
  }
}
