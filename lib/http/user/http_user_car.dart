import 'package:dio/dio.dart';
import 'package:temp/http/instanse.dart';
import 'package:temp/localStorage/tokenStorage/token_storage.dart';
import 'package:temp/models/car/car.dart';
import 'package:temp/models/preferences/preferences.dart';

const baseUrl="https://ezride.pro/api/v1/client/auto";

class ClientCar{
  int modelId;
  int manufacturerId;
  int numberOfSeats;
  String color="blue";
  String autoNumber;
  String year;
  Preferences preferences;
  ClientCar({
    required this.modelId,
    required this.manufacturerId,
    required this.numberOfSeats,
    required this.autoNumber,
    required this.year,
    required this.preferences
  });


  Map<String,dynamic> toJson(){
    return {
      "model_id":modelId,
      "manufacturer_id":manufacturerId,
      "number_of_seats":numberOfSeats,
      "color":color,
      "auto_number":autoNumber,
      "year":year,
      "preferences":preferences.toJson()
    };
  }
}


///get car


class HttpUserCar{
 
  Dio dio=Dio();
  HttpUserCar(){
    final authInterceptor = AuthInterceptor(dio);
    dio.interceptors.add(authInterceptor);
  }

 Future<int> createUserCar(ClientCar clientCar)async{

  String access= tokenStorage.accessToken;
  if(access=="no") return -1;

  try{
   Response response = await dio.post(
    baseUrl,
    data: clientCar.toJson(),
    options: Options(
      headers: {
        "Authorization":"Bearer $access"
      }
    )
    );
    print(response.data);
    return response.data["data"]["car_id"];
  }catch(e){
    print(e);
      return -1;
  }
 
 }

 Future<List<UserCar>> getUserCar()async{
   String access= tokenStorage.accessToken;
  if(access=="no") return [];
   
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
    List<UserCar> userCar=[];
    List<dynamic>list= response.data["data"];
    userCar=list.map(
      (el) =>UserCar(
        carId: el["car_id"], 
        numberOfSeats: el["number_of_seats"], 
        model: el["model"], 
        manufacturer: el["manufacturer"], 
        autoNumber: el["auto_number"], 
        color: el["color"], 
        year: el["year"], 
        preferences: Preferences(
          smoking: el["preferences"]["smoking"], 
          luggage: el["preferences"]["luggage"], 
          childCarSeat: el["preferences"]["child_car_seat"], 
          animals: el["preferences"]["animals"]
          ))
      ).toList();
    print(response.data);

    return userCar;
  }catch(e){
    return [];
  }
 }

 
}