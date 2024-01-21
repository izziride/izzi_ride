import 'package:dio/dio.dart';
import 'package:temp/http/instanse.dart';
import 'package:temp/localStorage/tokenStorage/token_storage.dart';
import 'package:temp/models/user/user_data.dart';

const baseUrl="http://31.184.254.86:9099/api/v1/client/info";
const baseAppUrl="http://31.184.254.86:9099/api/v1/";



class HttpUser{
 Dio dio=Dio();
 HttpUser(){
  dio.interceptors.add(AuthInterceptor(dio));
 }
 Future<int> createUser(String nickname)async{

  String access= tokenStorage.accessToken;
  if(access=="no") return -1;

  Response response; 
  try{
    response = await dio.post(
    "http://31.184.254.86:9099/api/v1/client/info",
    data: {
      "nickname":nickname
    },
    options: Options(
        headers: {
          "Authorization":"Bearer $access"
        }
      )
    );
    return 0;
  }catch(e){
      return -1;
  }
 
 }

 Future<int> editUser(String nickname)async{

  String access= tokenStorage.accessToken;
  if(access=="no") return -1;


  Response response; 
  try{
    response = await dio.put(
    "http://31.184.254.86:9099/api/v1/client/info",
    data: {
      "nickname":nickname
    } 
    );
    print(response.data);
    return 0;
  }catch(e){
      return -1;
  }
 
 }

 Future<UserData?> getUser()async{
   String access= tokenStorage.accessToken;

  Response response; 

  try{
    response = await dio.get(
      baseUrl,
      options: Options(
        headers: {
          "Authorization":"Bearer $access"
        }
      )
    );
    print("userDataRepsonse");
    print(response.data);
    final res=response.data["data"];
    return UserData(
      clienId: res["client_id"]??-1,
      dateOfBirth: res["date_of_birth"]??0, 
      gender: res["gender"]??0, 
      name: res["name"]??"", 
      nickname: res["nickname"]??"", 
      photo: res["photo"]??"", 
      surname: res["surname"]??"");
  }catch(e){
    print(e);
    return null;
  }
 }

 Future<bool?> getPermission(String permission)async{
       String access= tokenStorage.accessToken;

       try {
       Response  response = await dio.get(
      "${baseAppUrl}client/permission/${permission}",
      options: Options(
        headers: {
          "Authorization":"Bearer $access"
        }
      )
    
    );
    print("perm");
      print(response.data["data"]["permission"]);
      bool permissionVal=response.data["data"]["permission"]??false;
      return permissionVal;
       } catch (e) {
         print(e);
         false;
       }
 }

 Future<int> deleteUser()async{

  String access= tokenStorage.accessToken;
  if(access=="no") return -1;

  Response response; 
  try{
    response = await dio.delete(
    "http://31.184.254.86:9099/api/v1/client",
    );
    print(response.data);
    return 0;
  }catch(e){
      return -1;
  }
 
 }
}