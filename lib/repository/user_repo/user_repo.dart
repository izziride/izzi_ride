
import 'package:mobx/mobx.dart';
import 'package:temp/http/orders/orders.dart';
import 'package:temp/http/user/http_user.dart';
import 'package:temp/http/user/http_user_car.dart';
import 'package:temp/models/car/car.dart';
import 'package:temp/models/user/user_data.dart';

part 'user_repo.g.dart';

class UserRepo = _UserRepo with _$UserRepo;

abstract class _UserRepo with Store {


  @action
  void CLEANUSERREPO(){
    isAuth=false;
    userInfo=UserData(
      clienId: -1,
      dateOfBirth: 0, 
      gender:"", 
      name: "", 
      nickname: "", 
      photo: "", 
      surname: ""
  );
  userCar=ObservableList.of([]);
  userOrders=ObservableList.of([]);
  userBookedOrders=ObservableList.of([]);
  userOrderFullInformation=null;
  }

  bool isAuth=false;
  @observable
  UserData userInfo=UserData(
      clienId: -1,
      dateOfBirth: 0, 
      gender:"", 
      name: "", 
      nickname: "", 
      photo: "", 
      surname: ""
  );

  @action
  Future<void> getUserInfo()async {
     UserData? userData=await HttpUser().getUser();
     print("userData");
     print(userData);
     if(userData!=null){
      userInfo=userData;
     }
  }

  @observable
  ObservableList<UserCar>? userCar;

  @observable
  bool carHasError=false;

  @action
  Future<void> getUserCar()async{
   List<UserCar>? listCar= await HttpUserCar().getUserCar();
   if(listCar!=null){
      userCar=ObservableList.of(listCar);
   }else{
    carHasError=true;
   }
  }

  @action
  Future<void> deleteUserCar(int carId)async{
   int result= await HttpUserCar().deleteUserCar(carId);
   if(result==0){
      userCar=ObservableList.of(userCar!.where((element) => element.carId!=carId).toList());
   }
  }

  @action
  Future<int> addUserCar(ClientCar car)async{
   int result= await HttpUserCar().createUserCar(car);
   if(result!=-1){
    getUserCar();
    return result;
   }
    return -1;
  }


  @observable
  ObservableList<DriverOrder> userOrders = ObservableList();


  //check user orders
  @observable
  bool isFirstLoaded=false;

  @action
  Future<void> getUserOrders()async{
   List<DriverOrder> listOrders= await HttpUserOrder().getUserOrders();
   if(listOrders.isNotEmpty){
      userOrders=ObservableList.of(listOrders);
   }
   isFirstLoaded=true;
  }

  @action
  void addUserOrders(DriverOrder order){
      userOrders.add(order);
      userOrders=ObservableList.of(userOrders);
  }

   @action
  void editUserOrdersSeatsInOrder(int orderId,String type){
      final currUserOrders=userOrders.firstWhere((element) => element.orderId==orderId);
      print(currUserOrders);
      if(type=="accepted"){
        currUserOrders.seatsInfo.free=currUserOrders.seatsInfo.free-1;
        currUserOrders.seatsInfo.reserved=currUserOrders.seatsInfo.reserved+1;
      }else{
        currUserOrders.seatsInfo.free=currUserOrders.seatsInfo.free+1;
        currUserOrders.seatsInfo.reserved=currUserOrders.seatsInfo.reserved-1;
      } 
      userOrders=ObservableList.of(userOrders);
  }
  

   //check user booked orders
  @observable
  bool isFirstLoadedBooked=false;

  @observable
  ObservableList<DriverOrder> userBookedOrders = ObservableList();

  @action deleteUserBookedOrders(int orderId){
    userBookedOrders=ObservableList.of(userBookedOrders.where((element) => element.orderId!=orderId));
  }

  @action
  Future<void> getUserBookedOrders()async{
    List<DriverOrder> listOrders= await HttpUserOrder().myTrips();
    userBookedOrders=ObservableList.of(listOrders);
    isFirstLoadedBooked=true;
  }
  @action
  Future<void> editStatusOrder(int orderId,String newStatus)async{
    final orders = userBookedOrders;
    for(int i=0;i<orders.length;i++){
      if(orders[i].orderId==orderId){
        orders[i].orderStatus=newStatus;
        userBookedOrders=ObservableList.of(orders);
        break;
      }
    }
  }

  @action
  Future<void> cancelBookedOrderByUser(int orderId)async{
    final orders = userBookedOrders;
    for(int i=0;i<orders.length;i++){
      if(orders[i].orderId==orderId){
        orders[i].seatsInfo.free=orders[i].seatsInfo.free+1;
        orders[i].seatsInfo.reserved=orders[i].seatsInfo.reserved-1;
        userBookedOrders=ObservableList.of(orders);
        break;
      }
    }
  }

  @observable
  UserOrderFullInformation? userOrderFullInformation;
  @observable
  bool userOrderFullInformationError=false;
  @action
  Future<void> getUserFullInformationOrder(int orderId)async{
   UserOrderFullInformation? order= await HttpUserOrder().getOrderInfo(orderId);
   if(order!=null){
      userOrderFullInformation=order;
   }else{
    userOrderFullInformationError=true;
   }
  }

   @action
  Future<void> getUserFullInformationOrderWithouOrderId()async{
    if(userOrderFullInformation!=null){
      UserOrderFullInformation? order= await HttpUserOrder().getOrderInfo(userOrderFullInformation!.orderId);
      if(order!=null){
          userOrderFullInformation=order;
      }else{
        userOrderFullInformationError=true;
      }
    }
   
  }

  @action
  Future<void> deleteUserByOrder(int orderId,int clientId)async{
   int result= await HttpUserOrder().deleteUserInOrder(orderId, clientId);
   if(result==0 && userOrderFullInformation!=null){
    
   }
    getUserFullInformationOrder(orderId);
  }


  @action
  Future<int> cancelOrder(int orderId,String comment)async{
   int status= await HttpUserOrder().orderDriverCancel(orderId, "");
   if(status==0){
    final newOrders=userOrders.where((element) => element.orderId!=orderId).toList();
    userOrders=ObservableList.of(newOrders);
    return 0;
   }else{
    return -1;
   }
  }
  @action
  Future<int> deleteUserBy(int orderId,String comment)async{
   int status= await HttpUserOrder().orderDriverCancel(orderId, "");
   if(status==0){
    final newOrders=userOrders.where((element) => element.orderId!=orderId).toList();
    userOrders=ObservableList.of(newOrders);
    return 0;
   }else{
    return -1;
   }
  }
} 


UserRepo userRepository=UserRepo();