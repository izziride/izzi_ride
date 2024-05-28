import 'package:dio/dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:temp/http/city/city_model.dart';
import 'package:temp/http/instanse.dart';

const baseUrl="https://ezride.pro/api/v1/city";


class HttpCity{

  Future<List<CityModel>> getCity(String city) async{
    try {
      Dio dio=Dio();

    Response response;

    final authInterceptor=AuthInterceptor(dio);
    dio.interceptors.add(authInterceptor);

   response=await dio.get(
    baseUrl,
    queryParameters: {
        "name":city
    }
    );
    
    List res=response.data["data"];
    List<CityModel> cityList=[];
    for (var element in res) {
      //cityList.add(CityModel(element["city_id"], elementb["state_id"], element["city"], element["state"], element["county"], element["longitude"], element["latitude"]));
    }
    return cityList;
    } catch (e,stackTrace) {
      Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
      return [];
    }
    
  }
}