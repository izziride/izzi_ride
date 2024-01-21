
import 'package:mobx/mobx.dart';
import 'package:temp/http/user/http_user.dart';
import 'package:temp/http/user/http_user_car.dart';
import 'package:temp/models/car/car.dart';
import 'package:temp/models/user/user_data.dart';

part 'user_repo.g.dart';

class UserRepo = _UserRepo with _$UserRepo;

abstract class _UserRepo with Store {
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
  ObservableList<UserCar> userCar = ObservableList();

  @action
  Future<void> getUserCar()async{
   List<UserCar> listCar= await HttpUserCar().getUserCar();
   userCar=ObservableList.of(listCar);
  }
} 


UserRepo userRepository=UserRepo();