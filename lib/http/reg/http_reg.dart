import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:temp/http/instanse.dart';
const baseUrl="https://ezride.pro/api/v1/sign";
const baseUrlOtp="https://ezride.pro/api/v1/otp";
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
    }catch(e,stackTrace){
      Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
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
    }catch(e,stackTrace){
      Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
        return -1;
    }
      
  }
}