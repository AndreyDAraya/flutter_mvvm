import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_item.freezed.dart';
part 'news_item.g.dart';

@freezed
class NewsItem with _$NewsItem {
  const factory NewsItem({
    required int id,
    required String title,
    required String? url,
    String? text,
    required int score,
    required int time,
    required String by,
    required int descendants,
    @Default([]) List<int> kids,
  }) = _NewsItem;

  factory NewsItem.fromJson(Map<String, dynamic> json) =>
      _$NewsItemFromJson(json);
}

@freezed
class NewsState with _$NewsState {
  const factory NewsState({
    @Default([]) List<NewsItem> items,
    @Default(false) bool isLoading,
    String? error,
  }) = _NewsState;
}
