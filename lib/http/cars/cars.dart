import 'package:dio/dio.dart';
import 'package:temp/http/instanse.dart';

class CarModel{
  int id;
  String name;
  CarModel(this.id,this.name);
}


class CarsHttp{


  Future<List<CarModel>> getName(String text)async{
    Dio dio=Dio();
    Response response;

    AuthInterceptor interceptor=AuthInterceptor(dio);

    dio.interceptors.add(interceptor);
    
    response=await dio.get(
      "https://ezride.pro/api/v1/car/manufacturer",
      queryParameters: {
        "name":text
      }
    );
      List<CarModel> carModels = [];
      List<dynamic> data = response.data["data"];
      carModels = data.map((item) => CarModel(item["id"], item["name"])).toList();
  
    return carModels;
  }

  Future<List<CarModel>> getModel(String text,int id)async{
    Dio dio=Dio();
    Response response;

    AuthInterceptor interceptor=AuthInterceptor(dio);

    dio.interceptors.add(interceptor);
    
    response=await dio.get(
      "https://ezride.pro/api/v1/car/model",
      queryParameters: {
        "name":text,
        "manufacturer_id":id
      }
    );
      List<CarModel> carModels = [];
      List<dynamic> data = response.data["data"];
      carModels = data.map((item) => CarModel(item["id"], item["name"])).toList();
  
    return carModels;
  }

}