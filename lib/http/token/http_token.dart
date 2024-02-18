import 'package:dio/dio.dart';
import 'package:temp/http/instanse.dart';
import 'package:temp/localStorage/tokenStorage/token_storage.dart';
//const baseUrl="https://ezride.pro/api/v1/refresh-token";

const baseUrl="https://ezride.pro/api/v1/refresh-token";

class HttpToken{
  Dio dio=Dio();
  HttpToken(){
    dio.interceptors.add(AuthInterceptor(dio));
  } 
  Future<String> refreshToken() async{
    final token =await TokenStorage().getToken();
    if(token=="no"){
      return "noAuth";
    }

     Response response;
    try{
        
      response = await dio.post(
      baseUrl,
      data:  {
        "token":token
      }
      );
      await tokenStorage.setToken(response.data["data"]["access_token"], response.data["data"]["refresh_token"]);

      return "auth";
    }catch(e){

      print("errorrrrr");
      if(e is DioException){
        if((e as DioException).response!.statusCode==409){
          return "version_conflict";
        }
      }
      return "noAuth";
    }
      
  }
}