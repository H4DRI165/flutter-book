class UserProgress {
  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      topicId: json['topic_id'] as String,
      status: ProgressStatus.fromString(json['status'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
  const UserProgress({
    required this.id,
    required this.userId,
    required this.topicId,
    required this.status,
    required this.updatedAt,
  });

  final String id;
  final String userId;
  final String topicId;
  final ProgressStatus status;
  final DateTime updatedAt;
}

enum ProgressStatus {
  notStarted,
  inProgress,
  completed;

  static ProgressStatus fromString(String value) => switch (value) {
    'in_progress' => ProgressStatus.inProgress,
    'completed' => ProgressStatus.completed,
    _ => ProgressStatus.notStarted,
  };

  String get value => switch (this) {
    ProgressStatus.notStarted => 'not_started',
    ProgressStatus.inProgress => 'in_progress',
    ProgressStatus.completed => 'completed',
  };
}
