import 'package:flutter_mvvm/core/api/api_client.dart';
import 'package:flutter_mvvm/core/api/api_response.dart';
import 'package:flutter_mvvm/features/news/domain/models/news_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class INewsRepository {
  Future<ApiResponse<List<int>>> getTopStories();
  Future<ApiResponse<NewsItem>> getStory(int id);
}

final newsRepositoryProvider = Provider<INewsRepository>((ref) {
  final apiClient = ApiClient();
  return NewsRepository(apiClient);
});

class NewsRepository implements INewsRepository {
  final ApiClient _apiClient;

  NewsRepository(this._apiClient);

  @override
  Future<ApiResponse<List<int>>> getTopStories() async {
    try {
      final response =
          await _apiClient.hackerNewsClient.get('/topstories.json');
      final List<dynamic> data = response.data;
      return ApiResponse.success(data.cast<int>());
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  @override
  Future<ApiResponse<NewsItem>> getStory(int id) async {
    try {
      final response = await _apiClient.hackerNewsClient.get('/item/$id.json');
      return ApiResponse.success(NewsItem.fromJson(response.data));
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
