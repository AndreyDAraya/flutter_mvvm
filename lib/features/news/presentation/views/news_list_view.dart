import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_mvvm/core/widgets/shimmer_loading.dart';
import 'package:flutter_mvvm/features/news/domain/models/news_item.dart';
import 'package:flutter_mvvm/features/news/presentation/viewmodels/news_viewmodel.dart';
import 'package:flutter_mvvm/features/news/presentation/views/news_item_card.dart';

class NewsListView extends ConsumerStatefulWidget {
  const NewsListView({super.key});

  @override
  ConsumerState<NewsListView> createState() => _NewsListViewState();
}

class _NewsListViewState extends ConsumerState<NewsListView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newsAsync = ref.watch(newsViewModelProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        children: [
          _buildHeader(theme),
          Expanded(
            child: newsAsync.when(
              data: (newsState) {
                if (newsState.isLoading) {
                  return _buildShimmerList();
                }

                if (newsState.error != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          newsState.error!,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 16),
                        _buildRetryButton(ref, theme),
                      ],
                    ),
                  );
                }

                if (newsState.items.isEmpty) {
                  return const Center(child: Text('No news available'));
                }

                return Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: newsState.items.length,
                        itemBuilder: (context, index) {
                          final item = newsState.items[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 16,
                            ),
                            child: NewsItemCard(
                              item: item,
                              onTap: () => _navigateToDetail(context, item),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 75,
                    )
                  ],
                );
              },
              loading: () => _buildShimmerList(),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      error.toString(),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    _buildRetryButton(ref, theme),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(newsViewModelProvider.notifier).refreshNews(),
        elevation: 0,
        backgroundColor: theme.colorScheme.surfaceBright,
        child: Icon(
          Icons.refresh,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.only(top: 48, bottom: 16),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.primary.withAlpha(51), // 0.2 * 255
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'TECH YORK TIME',
            style: GoogleFonts.unifrakturCook(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
              letterSpacing: 2,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                child: Divider(indent: 40, endIndent: 20),
              ),
              Text(
                _getFormattedDate(),
                style: theme.textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                  letterSpacing: 1,
                ),
              ),
              const Expanded(
                child: Divider(indent: 20, endIndent: 40),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRetryButton(WidgetRef ref, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 2,
        ),
      ),
      child: ElevatedButton(
        onPressed: () => ref.read(newsViewModelProvider.notifier).refreshNews(),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: theme.scaffoldBackgroundColor,
          foregroundColor: theme.colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
        child: const Text('RETRY'),
      ),
    );
  }

  Widget _buildShimmerList() {
    return PageView.builder(
      controller: PageController(viewportFraction: 0.9),
      itemCount: 5,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: NewsCardShimmer(),
      ),
    );
  }

  String _getFormattedDate() {
    final now = DateTime.now();
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return '${months[now.month - 1]} ${now.day}, ${now.year}';
  }

  void _navigateToDetail(BuildContext context, NewsItem item) {
    context.push('/detail', extra: item);
  }
}
