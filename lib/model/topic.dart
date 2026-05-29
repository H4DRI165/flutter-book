class Topic {
  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      difficulty: json['difficulty'] as String,
      explanation: json['explanation'] as String,
      codeSnippet: json['code_snippet'] as String,
      orderIndex: json['order_index'] as int,
      isFeatured: json['is_featured'] as bool,
      slug: json['slug'] as String,
      parentId: json['parent_id'] as String?,
      countsForProgress: json['counts_for_progress'] as bool,
    );
  }
  const Topic({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.explanation,
    required this.codeSnippet,
    required this.orderIndex,
    required this.isFeatured,
    required this.slug,
    this.parentId,
    required this.countsForProgress,
  });

  final String id;
  final String title;
  final String description;
  final String category;
  final String difficulty;
  final String explanation;
  final String codeSnippet;
  final int orderIndex;
  final bool isFeatured;
  final String slug;
  final String? parentId;
  final bool countsForProgress;
}
