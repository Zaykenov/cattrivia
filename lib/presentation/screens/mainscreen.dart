import 'dart:convert';

import 'package:cattrivia/data/model2/hiveinfo.dart';
import 'package:cattrivia/logic/service/hive_service.dart';
import 'package:cattrivia/presentation/screens/historyscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/model/cat_fact_model.dart';
import '../constants.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import '../../data/retrofit/cat_fact_service.dart';
import '../../data/model/cat_fact_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<CatFactResponse> _catFactFuture;
  final Dio _dio = Dio();
  String _imageUrl = 'https://cataas.com/cat';
  final formatter = DateFormat.yMd().add_jm();

  @override
  void initState() {
    super.initState();
    _catFactFuture = _getRandomCatFact();
    _imageUrl =
        'https://cataas.com/cat?${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<CatFactResponse> _getRandomCatFact() async {
    final response =
        await _dio.get('https://cat-fact.herokuapp.com/facts/random');
    final json = response.data as Map<String, dynamic>;
    return CatFactResponse.fromJson(json);
  }

  void _generateNewCatFact() {
    setState(() {
      _catFactFuture = _getRandomCatFact();
      _imageUrl =
          'https://cataas.com/cat?${DateTime.now().millisecondsSinceEpoch}';
    });
  }

  @override
  Widget build(BuildContext context) {
    var catfactsDb = Provider.of<HiveService>(context, listen: false);
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        title: const Text("Cat Trivia"),
        backgroundColor: mainColor,
        elevation: 0,
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HistoryScreen()));
                },
                child: const Icon(
                  Icons.history,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: FutureBuilder<CatFactResponse>(
            future: _catFactFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final catFact = snapshot.data!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 240,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        image: DecorationImage(
                          image: NetworkImage(_imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '${formatter.format(catFact.updatedAt)}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Color(0xFFB1A6BE)),
                    ),
                    SizedBox(height: 16),
                    Text(
                      catFact.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, color: Color(0xFFEEE9F5)),
                    ),
                    SizedBox(height: 32),
                    Consumer<HiveService>(
                      builder: (context, hiveService, widget) => ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _catFactFuture = _getRandomCatFact();
                            _imageUrl =
                                'https://cataas.com/cat?${DateTime.now().millisecondsSinceEpoch}';
                            catfactsDb.addItem(CatInfo(
                                updatedAt:
                                    '${formatter.format(catFact.updatedAt)}',
                                text: catFact.text));
                          });
                        },
                        child: Text('Generate New Cat Fact'),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
