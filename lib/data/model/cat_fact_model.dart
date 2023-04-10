import 'package:json_annotation/json_annotation.dart';
part 'cat_fact_model.g.dart';

@JsonSerializable()
class CatFactResponse {
  final String text;
  final DateTime updatedAt;

  CatFactResponse({required this.text, required this.updatedAt});

  factory CatFactResponse.fromJson(Map<String, dynamic> json) =>
      _$CatFactResponseFromJson(json);
}
