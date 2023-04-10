// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat_fact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatFactResponse _$CatFactResponseFromJson(Map<String, dynamic> json) =>
    CatFactResponse(
      text: json['text'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CatFactResponseToJson(CatFactResponse instance) =>
    <String, dynamic>{
      'text': instance.text,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
