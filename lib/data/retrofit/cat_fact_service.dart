import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../model/cat_fact_model.dart';

part 'cat_fact_service.g.dart';

@RestApi(baseUrl: "https://cat-fact.herokuapp.com")
abstract class CatFactApiClient {
  factory CatFactApiClient(Dio dio, {String baseUrl}) = _CatFactApiClient;

  @GET("/facts/random")
  Future<CatFactResponse> getRandomCatFact();
}
