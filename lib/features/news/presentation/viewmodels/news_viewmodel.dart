import 'package:flutter_mvvm/features/news/data/repositories/news_repository.dart';
import 'package:flutter_mvvm/features/news/domain/models/news_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'news_viewmodel.g.dart';

@riverpod
class NewsViewModel extends _$NewsViewModel {
  @override
  Future<NewsState> build() async {
    return _fetchNews();
  }

  Future<NewsState> _fetchNews() async {
    state = AsyncData(const NewsState(isLoading: true));

    final repository = ref.read(newsRepositoryProvider);
    final topStoriesResponse = await repository.getTopStories();

    return topStoriesResponse.when(
      success: (storyIds) async {
        try {
          final stories = await Future.wait(
            storyIds.take(20).map((id) async {
              final storyResponse = await repository.getStory(id);
              return storyResponse.when(
                success: (story) => story,
                error: (message) => throw Exception(message),
                loading: () => throw Exception('Loading timeout'),
              );
            }),
          );

          return NewsState(items: stories);
        } catch (e) {
          return NewsState(error: e.toString());
        }
      },
      error: (message) => NewsState(error: message),
      loading: () => const NewsState(isLoading: true),
    );
  }

  Future<void> refreshNews() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchNews());
  }
}
