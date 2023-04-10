import 'package:hive/hive.dart';
part 'hiveinfo.g.dart';

@HiveType(typeId: 0)
class CatInfo extends HiveObject {
  @HiveField(0)
  String updatedAt;
  @HiveField(1)
  String text;

  CatInfo({
    required this.updatedAt,
    required this.text,
  });
}
