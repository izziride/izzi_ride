
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/http/user/http_user_car.dart';
import 'package:temp/models/car/car.dart';
import 'package:temp/pages/main/tabs/create/auto/auto_title.dart';
import 'package:temp/pages/main/tabs/create/card_order/card_order_redact/UI/variable_car.dart';
import 'package:temp/pages/main/tabs/profile/user_car/create_car.dart';
import 'package:temp/pages/main/tabs/profile/user_car/provider/provider.dart';
import 'package:temp/pages/main/tabs/search/result_search/bar_navigation.dart';
import 'package:temp/repository/user_repo/user_repo.dart';

class UserAutoUI extends StatefulWidget{
  const UserAutoUI({super.key});

  @override
  State<UserAutoUI> createState() => _UserAutoUIState();
}

class _UserAutoUIState extends State<UserAutoUI> {

int currentCar=0;

 @override
  void initState() {
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: Column(
        children: [
          BarNavigation(back: true, title: "My cars"),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: variableAuto()
              ),
          ),
          Builder(
            builder: (context) {

             
              

              return Padding(
                                padding: EdgeInsets.only(bottom: 25,left: 15,right: 15),
                                child:InkWell(
                                  onTap: (){
                                    Navigator.push(
                                      context, MaterialPageRoute(
                                        builder: (context) 
                                        => ChangeNotifierProvider<DataProvider>(
                                          create: (context) => DataProvider(),
                                          
                                          child: CreateCar()
                                          ),
                                      )
                                      );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color:brandBlue,
                                      borderRadius: BorderRadius.circular(10)
                                      
                                    ),
                                    child: Text(
                                      "Add",
                                      style: TextStyle(
                                color:Colors.white,
                                fontFamily: "Inter",
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                                                      ),
                                                    ),
                                                  ),
                                                
                                  
                                              )
                              );
            }
          )
        ],
      ),
    );
  }


Widget variableAuto(){
    return Observer(
        builder: (context) {
          if(userRepository.carHasError){
            return Text("error");
          }
          if(userRepository.userCar==null){
            userRepository.getUserCar();
              return Column(
              children: [
                ShimmerVariableCar(),
                
              ],
            );
          }
          List<UserCar> usercars=userRepository.userCar!;
          if(usercars.isEmpty){
            return  Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/image/cars_empty.png"),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 7,vertical: 16),
                      child: Text(
                            "You don't have any cars added yet. Add your first vehicle and start benefiting from using our app!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              
                              color: brandBlack,
                              fontFamily: "SF",
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                    ),
                  ],
                ),
              
            );
          }
          currentCar=usercars[0].carId;
          return  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for(int i=0;i<usercars.length;i++) 
                  VariableCar( pressed: true,userCar:usercars[i]),
                GestureDetector(
                  onTap: () {
                   Navigator.push(
                    context, MaterialPageRoute(
                      builder: (context) 
                      => ChangeNotifierProvider<DataProvider>(
                        create: (context) => DataProvider(),
                        
                        child: CreateCar()
                        ),
                    )
                    );
                  },
                  child: SizedBox(
                    height: 40,
                    
                    child: Text(
                      "+ add car",
                      style: TextStyle(
                        color: brandBlue,
                        fontFamily: "SF",
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                )
              ],
          );
          
        },
        );
  }
}