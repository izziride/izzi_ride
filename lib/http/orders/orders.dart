import 'dart:developer';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:temp/helpers/error_impl.dart';
import 'package:temp/http/instanse.dart';
import 'package:temp/http/user/http_user_car.dart';
import 'package:temp/localStorage/tokenStorage/token_storage.dart';
import 'package:temp/models/preferences/preferences.dart';

const baseUrl="https://ezride.pro/api/v1/order";
const baseUrlDriver="https://ezride.pro/api/v1/driver/orders";
const baseUrlFindOrder="https://ezride.pro/api/v1/orders/find";
const baseUrlFindOrderInId="https://ezride.pro/api/v1/order";
const baseAppUrl="https://ezride.pro/api/v1/";
class UserOrder{
  int clientAutoId; 
  RideInfo rideInfo;
  List<Location> locations;

  UserOrder({
    required this.clientAutoId,
    required this.rideInfo,
    required this.locations
  });

  Map<String,dynamic> toJson(){
    return {
      "client_auto_id":clientAutoId,
      "ride_info":rideInfo.toJson(),
      "payment_info":{"type":1 },
      "locations":locations.map((loc) =>loc.toJson()).toList()
    };
  }
}

 class Location{
   String city;
   String state;
   int sortId;
   bool pickUp;
   String location;
   double longitude;
   double latitude;
   String departureTime;
   Location({
    required this.city,
    required this.state,
    required this.sortId,
    required this.pickUp,
    required this.location,
    required this.longitude,
    required this.latitude,
    required this.departureTime
   });

   Map<String,dynamic> toJson(){
    return {
      "city":city,
      "state":state,
      "sort_id":sortId,
      "pick_up":pickUp,
      "location":location,
      "longitude":longitude,
      "latitude":latitude,
      "departure_time":dateConverter()
    };
   }
   String dateConverter(){
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ssZ');
    String formattedTime = formatter.format(DateTime.parse(departureTime));
    String tzName(Duration offset) {
      String hours = offset.inHours.abs().toString().padLeft(2, '0');
      String minutes = (offset.inMinutes % 60).abs().toString().padLeft(2, '0');
      String sign = offset.isNegative ? '-' : '+';

      return '$sign$hours:$minutes';
    }
    formattedTime += tzName(DateTime.parse(departureTime).timeZoneOffset);

    return formattedTime;
   }
  }

class RideInfo{
  double price;
  int numberOfSeats;
  String comment;
  Preferences preferences;
  RideInfo({
    required this.comment,
    required this.price,
    required this.numberOfSeats,
    required this.preferences
  });

  Map<String,dynamic> toJson(){
    return {
      "comment":comment,
      "price":price,
      "number_of_seats":numberOfSeats,
      "preferences":preferences.toJson()
    };
  }
}
/////driver/orders
class SeatsInfo{
  int total;
  int reserved;
  int free;
  SeatsInfo({
    required this.total,
    required this.reserved,
    required this.free
  });
}

class DriverOrder{
  int userId;
  int orderId;
  int clientAutoId;
  String departureTime;
  String nickname;
  String orderStatus;
  String startCountryName;
  String endCountryName;
  SeatsInfo seatsInfo;
  double price;
  Preferences preferences;
  String status;
  String? bookedStatus;
  double driverRate;
  DriverOrder({
    required this.driverRate,
    required this.bookedStatus,
    required this.status,
    required this.userId,
    required this.orderId,
    required this.clientAutoId,
    required this.departureTime,
    required this.nickname,
    required this.orderStatus,
    required this.startCountryName,
    required this.endCountryName,
    required this.seatsInfo,
    required this.price,
    required this.preferences
  });
}

class Automobile {

  String model;
  String manufacturer;
  String number;
  String year;
  Automobile({
    required this.model,
    required this.manufacturer,
    required this.number,
    required this.year
  });
}

class UserOrderFullInformation extends DriverOrder{
  List<Travelers> travelers;
  List<Location> location;
  String? comment;
  int? driverId;
  bool isDriver;
  Automobile automobile;
  String giveAway;
  int? orderRate;
  UserOrderFullInformation({
    required this.orderRate,
    required super.bookedStatus,
    required super.status,
    required super.userId,
    required this.isDriver,
    required this.automobile,
    this.driverId,
    this.comment,
    required super.orderId, 
    required super.driverRate,
    required super.clientAutoId, 
    required super.departureTime, 
    required super.nickname, 
    required super.orderStatus, 
    required super.startCountryName, 
    required super.endCountryName, 
    required super.seatsInfo, 
    required super.price, 
    required super.preferences,
    required this.travelers,
    required this.location,
    required this.giveAway
    });
  
}
class Travelers{
  int userId;
  String nickname;
  double rate;
  double? driverRate;
  Travelers({
    required this.userId,
    required this.nickname,
    required this.driverRate,
    required this.rate
  });
}
class PointLocation{
  String city;
  double latitude;
  double longitude;
  PointLocation({
    required this.city,
    required this.latitude,
    required this.longitude
  });
}
class DriverOrderFind{
  int? clientReservedSeats;
  String bookedStatus;
  int orderId;
  int driverId;
  String driverCar;
  String departureTime;
  String nickname;
  PointLocation startPoint;
  PointLocation endPoint;
  double price;
  Preferences preferences;
  SeatsInfo seatsInfo;
  double driverRate;
  DriverOrderFind({
    this.clientReservedSeats,
    required this.bookedStatus,
    required this.orderId,
    required this.driverId,
    required this.driverCar,
    required this.departureTime,
    required this.nickname,
    required this.startPoint,
    required this.endPoint,
    required this.price,
    required this.preferences,
    required this.seatsInfo,
    required this.driverRate
  });
}





class HttpUserOrder{
 
  Dio dio=Dio();
  HttpUserOrder(){
    final authInterceptor = AuthInterceptor(dio);
    dio.interceptors.add(authInterceptor);
  }

  Future<int> rateUser(int orderId,String comment,int rate,int reviewedId)async{

    String access = tokenStorage.accessToken;
  
    try{
    Response response = await dio.post(
      "${baseAppUrl}order/review",
      data: {
        "order_id":orderId,
        "comment":comment,
        "rate":rate,
        "reviewed_id":reviewedId
      },
      options: Options(
        headers: {
          "Authorization":"Bearer $access"
        }
      )
      );
      print(response.data);
      return 0;
    }catch (e,stackTrace ){
      Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
      if(e is DioException){
        final error = e;
        if(error.response!=null && error.response!.data["code"]!=null){
          return error.response!.data["code"];
        }
      }
        return -1;
    }
 
 }

  Future<int> hideOrderBooking(int orderId)async{

  String access = tokenStorage.accessToken;
  print(orderId);
  try{
   Response response = await dio.put(
    "${baseAppUrl}client/order/$orderId/hide",
    options: Options(
      headers: {
        "Authorization":"Bearer $access"
      }
    )
    );
    print(response.data);
    return 0;
  }catch (e,stackTrace ){
    print(e);
    Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
    if(e is DioException){
      throw e;
    }
      return -1;
  }
 
 }

 Future<int> createUserOrder(UserOrder userOrder)async{

  String access = tokenStorage.accessToken;
  if(access=="no") return -1;
  print(userOrder.toJson());
  try{
   Response response = await dio.post(
    baseUrl,
    data: userOrder.toJson(),
    options: Options(
      headers: {
        "Authorization":"Bearer $access"
      }
    )
    );
   print("create---");
    print(response.data);
    return 0;
  }catch (e,stackTrace){
    if(e is DioException){
      
      Sentry.captureException(
        {
          "error":e,
          "info":{
            "response":e.response?.data??"NO RESPONSE",
            "message":e.message??"NO MESSAGE",
            "reqdata":e.requestOptions.data??"NO DATA",
            "context":"create user driver order"
          }
        },
        stackTrace: stackTrace,
      );
    }else{
      Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
    }
    
    print(e);
      rethrow;
  }
 
 }
  Future<int> deleteUserByOrder(int orderId,String comment,int userId)async{
    String access = tokenStorage.accessToken;
    if(access=="no") return -1;
    try{
    Response response = await dio.delete(
      baseAppUrl+"/order/client",
      data: {
        "order_id":orderId,
        "comment":comment,
        "client_id":userId
      },
      options: Options(
        headers: {
          "Authorization":"Bearer $access"
        }
      )
      );

      print(response.data);
      return 0;
    }catch (e,stackTrace){
      Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
      print(e);
        return -1;
    }
 }

 Future<int> cancelOrder(int orderId,String comment)async{
    String access = tokenStorage.accessToken;
    if(access=="no") return -1;
    try{
    Response response = await dio.put(
      baseAppUrl+"order/cancel",
      data: {
        "order_id":orderId,
        "comment":comment
      },
      options: Options(
        headers: {
          "Authorization":"Bearer $access"
        }
      )
      );

      print(response.data);
      return 0;
    }catch (e,stackTrace){
      Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
      print(e);
        return -1;
    }
 }

   Future<List<DriverOrder>> getUserOrders()async{
    String access= tokenStorage.accessToken;
    if(access=="no") return [];
    print(access);
    try {
      Response response = await dio.get(
    baseUrlDriver,
    options: Options(
      headers: {
        "Authorization":"Bearer $access"
      }
    )
    );
    print("respon");
    print(response.data);
    if(response.data["data"]==null){
      return [];
    }
    List<DriverOrder> driverOrder=[];
    List<dynamic> orders=response.data["data"];
    driverOrder=orders.map((el) =>DriverOrder(
      driverRate: el["driver_rate"]+0.0,
      status: el["status"],
      bookedStatus: el["booked_status"],
      userId:  el["order_id"]??-1,
      orderId: el["order_id"], 
      clientAutoId: el["client_auto_id"], 
      departureTime: el["departure_time"],
      nickname: el["nickname"]??"N", 
      orderStatus: el["status"], 
      startCountryName: el["start_country_name"], 
      endCountryName: el["end_country_name"], 
      seatsInfo: SeatsInfo(
        total: el["seats_info"]["total"], 
        reserved: el["seats_info"]["reserved"], 
        free: el["seats_info"]["free"]
      ), 
      price:el["price"]+0.0 , 
      preferences: Preferences(
        smoking: el["preference"]["smoking"], 
        luggage: el["preference"]["luggage"], 
        childCarSeat: el["preference"]["child_car_seat"], 
        animals: el["preference"]["animals"]
        )
      )).toList();
       print(driverOrder);
    return driverOrder;
    } catch (e,stackTrace) {
      Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
      print("captureException");
      return [];
    }
  }

  Future<List<DriverOrderFind>> findUserOrder(int startPoint,int endPoint,int numberOfSeats,String date)async{
    print(date);
    String access= tokenStorage.accessToken;
    if(access=="no") return [];
    try {
      Response response = await dio.get(
    baseUrlFindOrder,
    queryParameters: {
      "start_point":startPoint,
      "end_point":endPoint,
      "number_of_seats":numberOfSeats,
      "date":date

    },
    options: Options(
      headers: {
        "Authorization":"Bearer $access"
      }
    )
    );

    List<DriverOrderFind> driverOrder=[];
    print("FindOrderData");
    print(response.data); 
    if (response.data["data"]==null)
      return [];
     
    List<dynamic> orders=response.data["data"];
    driverOrder=orders.map((el) =>DriverOrderFind(
      bookedStatus: el["booked_status"]??"",
      orderId: el["order_id"], 
      driverId: el["driver_id"],
      driverCar: el["driver_car"], 
      departureTime: el["departure_time"],
      nickname: el["driver_nickname"]??"N", 
      startPoint:PointLocation(
        city: el["start_point"]["city"],
        longitude: el["start_point"]["longitude"],
        latitude: el["start_point"]["latitude"]
      ), 
      endPoint:PointLocation(
        city: el["end_point"]["city"],
        longitude: el["end_point"]["longitude"],
        latitude: el["end_point"]["latitude"]
      ),  
      seatsInfo: SeatsInfo(
        total: el["seats"]["total"], 
        reserved: el["seats"]["reserved"], 
        free: el["seats"]["free"]
      ), 
      price:el["order_price"]+0.0, 
      driverRate:el["driver_rate"]+.0 ,
      preferences: Preferences(
        smoking: el["preference"]["smoking"], 
        luggage: el["preference"]["luggage"], 
        childCarSeat: el["preference"]["child_car_seat"], 
        animals: el["preference"]["animals"]
        )
      )).toList();
    return driverOrder;
    } catch ( e,stackTrace) {
      if(e is Error){
        final stackTrace = e.stackTrace;
        
      }

      
      
      Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
      print(e);
      return [];
    }
  }


 Future<List<DriverOrderFind>> findUserOrderByOtherCity(int startPoint,int endPoint,int numberOfSeats,String date)async{
    String access= tokenStorage.accessToken;
    if(access=="no") return [];
    try {
      Response response = await dio.get(
    baseUrlFindOrder+"-nearest",
    queryParameters: {
      "start_point":startPoint,
      "end_point":endPoint,
      "number_of_seats":numberOfSeats,
      "date":date

    },
    options: Options(
      headers: {
        "Authorization":"Bearer $access"
      }
    )
    );

    List<DriverOrderFind> driverOrder=[];
    print("OTHER");
    inspect(response.data); 
    if (response.data["data"]==null)
      return [];
     
    List<dynamic> orders=response.data["data"];
    driverOrder=orders.map((el) =>DriverOrderFind(
      bookedStatus: el["booked_status"]??"",
      orderId: el["order_id"], 
      driverId: el["driver_id"],
      driverCar: el["driver_car"], 
      departureTime: el["departure_time"],
      nickname: el["driver_nickname"]??"N", 
      driverRate:el["driver_rate"]+.0 ,
      startPoint:PointLocation(
        city: el["start_point"]["city"],
        longitude: el["start_point"]["longitude"],
        latitude: el["start_point"]["latitude"]
      ), 
      endPoint:PointLocation(
        city: el["end_point"]["city"],
        longitude: el["end_point"]["longitude"],
        latitude: el["end_point"]["latitude"]
      ),  
      seatsInfo: SeatsInfo(
        total: el["seats"]["total"], 
        reserved: el["seats"]["reserved"], 
        free: el["seats"]["free"]
      ), 
      price:el["order_price"]+0.0, 
      
      preferences: Preferences(
        smoking: el["preference"]["smoking"], 
        luggage: el["preference"]["luggage"], 
        childCarSeat: el["preference"]["child_car_seat"], 
        animals: el["preference"]["animals"]
        )
      )).toList();
    return driverOrder;
    } catch (e,stackTrace) {
      Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
      print(e);
      return [];
    }
  }


  Future<List<String>> findUserSimilarOrder(int startPoint,int endPoint,int numberOfSeats,String date)async{
    String access= tokenStorage.accessToken;
    if(access=="no") return [];
    print('similar ${date}');
    try {
      Response response = await dio.get(
    "$baseUrlFindOrder-similar",
    queryParameters: {
      "start_point":startPoint,
      "end_point":endPoint,
      "number_of_seats":numberOfSeats,
      "date":date

    },
    options: Options(
      headers: {
        "Authorization":"Bearer $access"
      }
    )
    );
     print("SimilarData");
      print(response.data);
      if(response.data["data"]==null){
        return [];
      }
      List<dynamic> list=response.data["data"];
      List<String> similarList=list.map<String>((e) => e as String).toList();
      return similarList;
    } catch (e,stackTrace) {
      print(e);
      return [];
    }
  }

  Future<UserOrderFullInformation?> getOrderInfo(int orderId)async{
    String access= tokenStorage.accessToken;
    print("get full order");
    try {
      Response response=await dio.get(
        baseUrlFindOrderInId+"/"+orderId.toString(),
        options: Options(
      headers: {
        "Authorization":"Bearer $access"
      }
    )
      );
      print("get full order end");
      Map<String,dynamic> _mapResponse=response.data["data"];
      inspect(_mapResponse);
      List<dynamic> _locationsResponse=_mapResponse["locations"];
      
     List<Location> _locations= _locationsResponse.map((el){
        return Location(
          city: el["city_name"], 
          state: el["state"], 
          sortId: el["sort_id"], 
          pickUp: el["pick_up"], 
          location: el["location"]??"", 
          longitude: el["longitude"]+0.0, 
          latitude:el ["latitude"]+0.0, 
          departureTime: el["departure_time"]
          );
      }).toList();
      List<dynamic>? _travelersResponse=_mapResponse["travelers"];
      List<Travelers> _travelers;
      if(_travelersResponse==null){
          _travelers=[];
      }else{
        _travelers=_travelersResponse.map((el) {
        return Travelers(
          userId: el["id"], 
          nickname: el["nickname"]==null?"No name":(el["nickname"] as String).isEmpty?"No name":el["nickname"],
          rate: el["rate"]+.0,
          driverRate: el["driver_rate"]!=null?el["driver_rate"]+.0:null
          );
      },).toList();
      }
      
       

     final fullOrderInfo=  UserOrderFullInformation(
      giveAway: _mapResponse["giveaway_code"]??"",
      orderRate: _mapResponse["order_rating"],
      driverRate: (_mapResponse["driver_rate"]??0)+0.0,
      status: _mapResponse["status"],
      bookedStatus: _mapResponse["booked_status"]??"_",
      userId: _mapResponse["user_id"]??-1,
      isDriver: _mapResponse["is_driver"],
      driverId: _mapResponse["driver_id"],
      comment: _mapResponse["comment"],
      orderId: _mapResponse["order_id"], 
      clientAutoId: _mapResponse["client_auto_id"], 
      departureTime: _mapResponse["departure_time"],
      nickname: _mapResponse["nickname"]??"N", 
      orderStatus: _mapResponse["status"]??"", 
      startCountryName: "", 
      endCountryName: "",
      automobile: Automobile(
        model: _mapResponse["automobile"]["model"], 
        manufacturer: _mapResponse["automobile"]["manufacturer"], 
        number: _mapResponse["automobile"]["number"], 
        year: _mapResponse["automobile"]["year"]
        ), 
      seatsInfo: SeatsInfo(
        total: _mapResponse["seats_info"]["total"], 
        reserved: _mapResponse["seats_info"]["reserved"], 
        free: _mapResponse["seats_info"]["free"]
      ), 
      price:_mapResponse["price"]+0.0 , 
      preferences: Preferences(
        smoking: _mapResponse["preference"]["smoking"], 
        luggage: _mapResponse["preference"]["luggage"], 
        childCarSeat: _mapResponse["preference"]["child_car_seat"], 
        animals: _mapResponse["preference"]["animals"]
        ),
      location: _locations,
      travelers: _travelers,
      );
      return fullOrderInfo;
    } catch (e,stackTrace) {
       print(e);
       Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
      return null;
     
    }
  }

  Future<int> orderBook(int orderId,int seats )async{
    String access= tokenStorage.accessToken;
    print("orderId: $orderId");
    print("seats:"+seats.toString());
    try {
      Response response=await dio.post(
        baseAppUrl+"order/book",
        data: {
          "order_id":orderId,
          "number_of_reserved_seats":seats
        },
        options: Options(
          headers: {
            "Authorization":"Bearer $access"
          }
        )
      );
      print(response.data);
      return 0;
    } catch (e,stackTrace) {
      Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
      if(e is DioException) {
        final error=e;
         if(error.response!=null && error.response!.data!=null  && error.response!.data!["code"]!=null){
            return error.response!.data!["code"]!;
         }
      }
     
      return -1;
    }
  }

  Future<int> orderCancel(int orderId)async{
    String access= tokenStorage.accessToken;
    try {
      Response response=await dio.put(
        baseAppUrl+"order-app/cancel/"+orderId.toString(),
        options: Options(
          headers: {
            "Authorization":"Bearer $access"
          }
        )
      );
      print(response.data);
      return 0;
    } catch (e,stackTrace) {
      return 1;
    }
  }
    Future<int> orderDriverCancel(int orderId,String comment)async{
    String access= tokenStorage.accessToken;
    try {
      Response response=await dio.put(
        baseAppUrl+"order/cancel",
        options: Options(
          headers: {
            "Authorization":"Bearer $access"
          },
         
        ),
         data:{
          "order_id":orderId,
          "comment":""
         }
      );
      print("cancel");
      print(response.data);
      return 0;
    } catch (e,stackTrace) {
      Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
      print(e);
      return 1;
    }
  }

  Future<List<DriverOrder>> myTrips()async{
    String access= tokenStorage.accessToken;
    try {
      Response response=await dio.get(
        baseAppUrl+"client/orders/booked",
        options: Options(
          headers: {
            "Authorization":"Bearer $access"
          }
        )
      );
      print(response.data);
      if(response.data["data"]==null){
        return [];
      }
     
    List<DriverOrder> driverOrder=[];
    List<dynamic> orders=response.data["data"];
    driverOrder=orders.map((el) =>DriverOrder(
      driverRate: el["driver_rate"]+0.0,
      status: el["status"],
      bookedStatus: el["booked_status"],
      clientAutoId: -1,
      endCountryName: el["end_point"]["city"],
      startCountryName: el["start_point"]["city"],
      orderStatus: el["status"]??"",
      orderId: el["order_id"], 
      userId: el["driver_id"],
      departureTime: el["departure_time"],
      nickname: el["driver_nickname"]??"N",  
      seatsInfo: SeatsInfo(
        total: el["seats"]["total"], 
        reserved: el["seats"]["reserved"], 
        free: el["seats"]["free"]
      ), 
      price:el["order_price"]+0.0, 
      
      preferences: Preferences(
        smoking: el["preference"]["smoking"], 
        luggage: el["preference"]["luggage"], 
        childCarSeat: el["preference"]["child_car_seat"], 
        animals: el["preference"]["animals"]
        )
      )).toList();
      return driverOrder;
      
    } catch (e,stackTrace) {
      Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
      print(e);
      return [];
    }
  }

  Future<int> editDriverOrder(int carId, int seats,String comment,Preferences preferences,int orderId)async{
    String access= tokenStorage.accessToken;
    try {
      Map data={
          "car_id":carId,
          "number_of_seats":seats,
          "comment":comment,
          "preference":preferences.toJson()
        };
        print(data);
      Response response=await dio.put(
        "${baseAppUrl}order/$orderId",
        data: data,
        options: Options(
          headers: {
            "Authorization":"Bearer $access"
          }
        )
      );
      print(response.data);
      return 0;
    } catch (e,stackTrace) {
      Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
      print(e);
      return 1;      
    }
  }

  Future<int> deleteUserInOrder(int orderId,int clientId)async{
    String access= tokenStorage.accessToken;
        try {
          Response response=await dio.delete(
        "${baseAppUrl}order/client",
        data: {
          "order_id":orderId,
          "client_id":clientId,
          "comment":"",
        },
        options: Options(
          headers: {
            "Authorization":"Bearer $access"
          }
        )
      );
      print(response.data);
      return 0;
        } catch (e,stackTrace) {
          Sentry.captureException(
            e,
            stackTrace: stackTrace,
          );
          print(e);
          return -1;
        }
  }
}