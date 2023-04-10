import 'dart:io';

import 'package:cattrivia/logic/service/hive_service.dart';
import 'package:flutter/material.dart';
import 'presentation/screens/mainscreen.dart';
import 'data/model2/hiveinfo.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(CatInfoAdapter());
  runApp(ListenableProvider(
    create: (context) => HiveService(),
    child: const MaterialApp(
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      home: MainScreen(),
    ),
  ));
}
