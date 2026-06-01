import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app.dart';
import 'bloc/main_menu_bloc.dart';

@RoutePage()
class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  @override
  void initState() {
    super.initState();
    context.read<MainMenuBloc>().add(const MainMenuStarted());
    context.router.addListener(_onRouteChanged);
  }

  @override
  void dispose() {
    context.router.removeListener(_onRouteChanged);
    super.dispose();
  }

  void _onRouteChanged() {
    if (context.router.current.name == MainMenuRoute.name) {
      context.read<MainMenuBloc>().add(const MainMenuRefreshDisplayName());
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocListener<MainMenuBloc, MainMenuPageState>(
        listener: (context, state) {
          if (state.status == MainMenuStatus.loggedOut) {
            context.router.replace(const LoginRoute());
          } else if (state.status == MainMenuStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to log out. Please try again.'),
              ),
            );
          } else if (state.status == MainMenuStatus.loadingFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to load topics. Please try again.'),
              ),
            );
          }
        },
        child: Builder(
          builder: (context) {
            return Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    _Header(),
                    const _SearchBar(),
                    const _FilterChips(),
                    const Expanded(
                      child: _Content(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  context.pushRoute(const ProfileRoute());
                },
                child: Row(
                  children: [
                    _Avatar(),
                    const SizedBox(width: 10),
                    BlocBuilder<MainMenuBloc, MainMenuPageState>(
                      buildWhen: (prev, curr) => prev.displayName != curr.displayName,
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _greeting(),
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              '${state.displayName} 👋',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFE8E8E8),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  AppIconButton(
                    icon: Icons.notifications_none_rounded,
                    onTap: () {},
                  ),
                  const SizedBox(width: 8),
                  AppIconButton(
                    icon: Icons.logout_rounded,
                    onLogout: true,
                    onTap: () {
                      context.read<MainMenuBloc>().add(
                        const MainMenuLogoutPressed(),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          BlocBuilder<MainMenuBloc, MainMenuPageState>(
            buildWhen: (prev, curr) => prev.userProgress != curr.userProgress || prev.topics != curr.topics,
            builder: (context, state) {
              return _ProgressCard(
                completed: state.completedCount,
                inProgress: state.inProgressCount,
                total: state.topics.length,
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }
}

class _SearchBar extends StatefulWidget {
  const _SearchBar();

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1C24),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF2E3140),
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search_rounded,
              size: 18,
              color: Colors.grey,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _controller,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  hintText: 'Search topics...',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF444444),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                ),
                onChanged: (value) {
                  context.read<MainMenuBloc>().add(
                    MainMenuSearchChanged(value),
                  );
                },
              ),
            ),
            BlocBuilder<MainMenuBloc, MainMenuPageState>(
              buildWhen: (prev, curr) => prev.searchQuery != curr.searchQuery,
              builder: (context, state) {
                if (state.searchQuery.isEmpty) return const SizedBox.shrink();
                return GestureDetector(
                  onTap: () {
                    _controller.clear();
                    context.read<MainMenuBloc>().add(
                      const MainMenuSearchChanged(''),
                    );
                  },
                  child: const Icon(
                    Icons.close_rounded,
                    size: 16,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  const _FilterChips();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainMenuBloc, MainMenuPageState>(
      buildWhen: (prev, curr) => prev.filter != curr.filter,
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
          child: Row(
            children: MainMenuFilter.values.map((filter) {
              final isActive = state.filter == filter;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () {
                    context.read<MainMenuBloc>().add(
                      MainMenuFilterChanged(filter),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isActive ? const Color(0xFF2A2E55) : const Color(0xFF1A1C24),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isActive ? const Color(0xFF3A3F7A) : const Color(0xFF2E3140),
                        width: 0.5,
                      ),
                    ),
                    child: Text(
                      filter.label,
                      style: TextStyle(
                        fontSize: 12,
                        color: isActive ? const Color(0xFF7B8EF5) : Colors.grey,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainMenuBloc, MainMenuPageState>(
      buildWhen: (prev, curr) => prev.filteredTopics != curr.filteredTopics || prev.status != curr.status,
      builder: (context, state) {
        if (state.status == MainMenuStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == MainMenuStatus.loadingFailure) {
          return const Center(child: Text('Failed to load topics.'));
        }

        final featured = state.featuredTopics;
        final all = state.filteredTopics;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (featured.isNotEmpty) ...[
                _SectionHeader(title: 'Featured', onSeeAll: () {}),
                const SizedBox(height: 10),
                ...featured.map(
                  (topic) {
                    final ui = topicUiFromSlug(topic.slug);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: AppCard(
                        onTap: () => navigateToTopic(
                          context: context,
                          slug: topic.slug,
                          topicId: topic.id,
                        ),
                        child: FeaturedLayout(
                          icon: ui.icon,
                          iconColor: ui.iconColor,
                          containerColor: ui.containerColor,
                          title: topic.title,
                          descriptionWidget: Text(
                            topic.description,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),
                          progressLabel: state.featuredProgressLabel(topic.id),
                          progressBarValue: state.featuredProgressValue(topic.id),
                          progressBarColor: Colors.purple,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
              ],
              _SectionHeader(title: 'All topics', onSeeAll: () {}),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: all.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 160,
                ),
                itemBuilder: (context, index) {
                  final topic = all[index];
                  final ui = topicUiFromSlug(topic.slug);

                  return AppCard(
                    onTap: () => navigateToTopic(
                      context: context,
                      slug: topic.slug,
                      topicId: topic.id,
                    ),
                    child: TopicLayout(
                      icon: ui.icon,
                      iconColor: ui.iconColor,
                      containerColor: ui.containerColor,
                      title: topic.title,
                      descriptionWidget: Text(
                        topic.description,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                      tag: topic.category,
                      tagContainerColor: _tagColor(topic.category),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Color _tagColor(String category) => switch (category) {
    'Layout' => Colors.blueAccent,
    'Common error' => const Color(0xFFFCEBEB),
    'Input' => Colors.tealAccent,
    _ => Colors.grey,
  };
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.onSeeAll});
  final String title;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: const Text(
            'See all',
            style: TextStyle(fontSize: 11, color: Color(0xFF5C6BC0)),
          ),
        ),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  String _extractInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainMenuBloc, MainMenuPageState>(
      buildWhen: (prev, curr) => prev.displayName != curr.displayName,
      builder: (context, state) {
        final initials = _extractInitials(state.displayName);

        return Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFF1E2340),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF2E3260), width: 0.5),
          ),
          child: Center(
            child: Text(
              initials,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF7B8EF5),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({
    required this.completed,
    required this.inProgress,
    required this.total,
  });

  final int completed;
  final int inProgress;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2A2E50), width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your progress',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                '$completed/$total completed',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF7B8EF5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Keep going! You\'re doing great.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFFE0E0E0),
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: total > 0 ? completed / total : 0,
              minHeight: 6,
              backgroundColor: const Color(0xFF252840),
              valueColor: const AlwaysStoppedAnimation(Color(0xFF5C6BC0)),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _StatBox(
                  value: '$completed',
                  label: 'Completed',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _StatBox(
                  value: '$inProgress',
                  label: 'In Progress',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _StatBox(
                  value: '${total - completed - inProgress}',
                  label: 'Remaining',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF13152A),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF252840), width: 0.5),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFFE0E0E0),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

extension MainMenuFilterLabel on MainMenuFilter {
  String get label => switch (this) {
    MainMenuFilter.all => 'All',
    MainMenuFilter.beginner => 'Beginner',
    MainMenuFilter.intermediate => 'Intermediate',
    MainMenuFilter.completed => 'Completed',
  };
}
