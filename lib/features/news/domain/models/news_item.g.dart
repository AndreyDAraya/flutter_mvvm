// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewsItemImpl _$$NewsItemImplFromJson(Map<String, dynamic> json) =>
    _$NewsItemImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      url: json['url'] as String?,
      text: json['text'] as String?,
      score: (json['score'] as num).toInt(),
      time: (json['time'] as num).toInt(),
      by: json['by'] as String,
      descendants: (json['descendants'] as num).toInt(),
      kids: (json['kids'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$NewsItemImplToJson(_$NewsItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'text': instance.text,
      'score': instance.score,
      'time': instance.time,
      'by': instance.by,
      'descendants': instance.descendants,
      'kids': instance.kids,
    };
