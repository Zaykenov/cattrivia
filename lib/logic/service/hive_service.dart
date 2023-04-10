import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';
import 'dart:collection';
import '../../data/model2/hiveinfo.dart';

class HiveService extends ChangeNotifier {
  final String catinfoHiveBox = 'catinfo-box';
  List _catInfoList = <CatInfo>[];
  List get catInfoList => _catInfoList;

  getItem() async {
    final box = await Hive.openBox<CatInfo>(catinfoHiveBox);

    _catInfoList = box.values.toList();

    notifyListeners();
  }

  addItem(CatInfo item) async {
    var box = await Hive.openBox<CatInfo>(catinfoHiveBox);

    box.add(item);

    notifyListeners();
  }
}
