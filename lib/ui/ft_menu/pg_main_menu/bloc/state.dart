part of 'main_menu_bloc.dart';

enum MainMenuStatus { initial, loading, success, failure, loggedOut }

enum MainMenuFilter { all, beginner, intermediate, completed }

class MainMenuPageState extends Equatable {
  const MainMenuPageState({
    this.status = MainMenuStatus.initial,
    this.filter = MainMenuFilter.all,
    this.topics = const [],
    this.userProgress = const [],
    this.searchQuery = '',
  });

  final MainMenuStatus status;
  final MainMenuFilter filter;
  final List<Topic> topics;
  final List<UserProgress> userProgress;
  final String searchQuery;

  List<Topic> get filteredTopics {
    var result = topics;

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

  List<Topic> get featuredTopics => topics.where((t) => t.isFeatured).toList();

  int get completedCount => userProgress.where((p) => p.status == ProgressStatus.completed).length;

  int get inProgressCount => userProgress.where((p) => p.status == ProgressStatus.inProgress).length;

  ProgressStatus progressFor(String topicId) {
    final match = userProgress.where((p) => p.topicId == topicId);
    return match.isEmpty ? ProgressStatus.notStarted : match.first.status;
  }

  MainMenuPageState copyWith({
    MainMenuStatus? status,
    MainMenuFilter? filter,
    List<Topic>? topics,
    List<UserProgress>? userProgress,
    String? searchQuery,
  }) {
    return MainMenuPageState(
      status: status ?? this.status,
      filter: filter ?? this.filter,
      topics: topics ?? this.topics,
      userProgress: userProgress ?? this.userProgress,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [status, filter, topics, userProgress, searchQuery];
}
