part of 'main_menu_bloc.dart';

enum MainMenuStatus {
  initial,
  loading,
  success,
  loggedOut,
  failure,
  loadingFailure,
}

enum MainMenuFilter {
  all,
  beginner,
  intermediate,
  completed,
}

class MainMenuPageState extends Equatable {
  const MainMenuPageState({
    this.status = MainMenuStatus.initial,
    this.filter = MainMenuFilter.all,
    this.topics = const [],
    this.userProgress = const [],
    this.searchQuery = '',
    this.displayName = '',
  });

  final MainMenuStatus status;
  final MainMenuFilter filter;
  final List<Topic> topics;
  final List<UserProgress> userProgress;
  final String searchQuery;
  final String displayName;

  List<Topic> get filteredTopics {
    var result = topics.where((t) => !t.isFeatured).toList();

    if (searchQuery.isNotEmpty) {
      result = result
          .where(
            (t) =>
                t.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
                t.category.toLowerCase().contains(searchQuery.toLowerCase()),
          )
          .toList();
    }

    switch (filter) {
      case MainMenuFilter.beginner:
        return result.where((t) => t.difficulty == 'beginner').toList();
      case MainMenuFilter.intermediate:
        return result.where((t) => t.difficulty == 'intermediate').toList();
      case MainMenuFilter.completed:
        return result.where((t) => progressFor(t.id) == ProgressStatus.completed).toList();
      case MainMenuFilter.all:
        return result;
    }
  }

  List<Topic> childrenOf(String parentId) =>
      topics.where((t) => t.parentId == parentId && t.countsForProgress).toList();

  String featuredProgressLabel(String parentId) {
    final children = childrenOf(parentId);
    if (children.isEmpty) return '';
    final completed = children.where((t) => progressFor(t.id) == ProgressStatus.completed).length;
    return '$completed / ${children.length} completed';
  }

  double featuredProgressValue(String parentId) {
    final children = childrenOf(parentId);
    if (children.isEmpty) return 0.0;
    final completed = children.where((t) => progressFor(t.id) == ProgressStatus.completed).length;
    return completed / children.length;
  }

  List<Topic> get featuredTopics => topics.where((t) => t.isFeatured).toList();

  int get completedCount => userProgress.where((p) => p.status == ProgressStatus.completed).length;

  int get inProgressCount => userProgress.where((p) => p.status == ProgressStatus.inProgress).length;

  ProgressStatus progressFor(String topicId) {
    final match = userProgress.where((p) => p.topicId == topicId);
    return match.isEmpty ? ProgressStatus.notStarted : match.first.status;
  }

  Topic? topicById(String id) {
    final match = topics.where((t) => t.id == id);
    return match.isEmpty ? null : match.first;
  }

  MainMenuPageState copyWith({
    MainMenuStatus? status,
    MainMenuFilter? filter,
    List<Topic>? topics,
    List<UserProgress>? userProgress,
    String? searchQuery,
    String? displayName,
  }) {
    return MainMenuPageState(
      status: status ?? this.status,
      filter: filter ?? this.filter,
      topics: topics ?? this.topics,
      userProgress: userProgress ?? this.userProgress,
      searchQuery: searchQuery ?? this.searchQuery,
      displayName: displayName ?? this.displayName,
    );
  }

  @override
  List<Object?> get props => [status, filter, topics, userProgress, searchQuery, displayName];
}
