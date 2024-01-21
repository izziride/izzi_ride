import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:temp/http/instanse.dart';
const baseUrl="http://31.184.254.86:9099/api/v1/sign";
const baseUrlOtp="http://31.184.254.86:9099/api/v1/otp";
class HttpReg{

    Dio dio = Dio();
    HttpReg(){
      dio.interceptors.add(AuthInterceptor(dio));
    }
  Future<Map<String,dynamic>> otpVerify(String code, String phone) async{

    Response response;

    try{

      response = await dio.post(
      baseUrlOtp,
      data:  {
        "code":code,
        "phone": phone,
        "step": "sign"
      }
      );
      
      
      return response.data["data"];
    }catch(e){
      inspect(e);
      DioException typeError= e as DioException;

        return {"message":typeError.response?.data["message"]};
    }
  }

  Future<int> signIn(String phone) async{

     Response response;

 
    try{
      print(phone);
      response = await dio.post(
      baseUrl,
      data:  {
        "phone":phone
      }
      );
      inspect(response.data);
      return 0;
    }catch(e){
        return -1;
    }
      
  }
}