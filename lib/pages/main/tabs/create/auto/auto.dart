
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/http/user/http_user_car.dart';
import 'package:temp/models/car/car.dart';
import 'package:temp/pages/main/tabs/create/auto/auto_title.dart';
import 'package:temp/pages/main/tabs/create/card_order/card_order_redact/UI/variable_car.dart';
import 'package:temp/pages/main/tabs/create/dop_options/dop_options.dart';
import 'package:temp/pages/main/tabs/profile/user_car/create_car.dart';
import 'package:temp/pages/main/tabs/profile/user_car/provider/provider.dart';
import 'package:temp/pages/main/tabs/search/result_search/bar_navigation.dart';
import 'package:temp/repository/user_repo/user_repo.dart';






class Auto extends StatefulWidget{
  final Function side;
  const Auto({required this.side, super.key});

  @override
  State<Auto> createState() => _AutoState();
}

class _AutoState extends State<Auto> {

 Widget currentWidget=Center(child: CircularProgressIndicator());

  int currentautoId=0;


  void checkUserCar()async{
    if(userRepository.userCar==null){
        await userRepository.getUserCar();
    }
    if(userRepository.userCar!=null&& userRepository.userCar!.isEmpty){
      setState(() {
              currentWidget=  AutoTitle(
                  side:widget.side
                );
            });
    }else{
      setState(() {
        currentautoId=userRepository.userCar![0].carId;
      });
    } 
  }

  @override
  void initState() {
    checkUserCar();
    super.initState();
  }

  String mode="variable";
  List<int> carIdForRemove=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            toolbarHeight: 0,
            backgroundColor: Colors.white,
            toolbarOpacity: 0,
            elevation: 1,
            
        ),
        body:userRepository.userCar==null ||  userRepository.userCar!.length==0
        ?currentWidget
        : Padding(
         padding: const EdgeInsets.only(left: 0,right: 0),
         child:  Column(
           children: [
              mode=="variable"
              ? BarNavigation(back: true, title: "My vehicles")
              :Container(
                height: 70,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: brandBlue,
                      width: 2
                    )
                  )
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          carIdForRemove=[];
                          mode="variable";
                        });
                      },
                      child: Icon(Icons.close,size: 35,color: brandBlue,)
                    ),
                    GestureDetector(
                      onTap: ()async {
                        for(int i=0;i<carIdForRemove.length;i++){
                            await userRepository.deleteUserCar(carIdForRemove[i]);
                          }
                        setState(() {
                          
                          checkUserCar();
                          carIdForRemove=[];
                          mode="variable";
                        });
                      },
                      child: Icon(Icons.delete_forever,size: 35,color: brandBlue,)
                    ),
                    
                  ],
                ),
              ),
             Observer(
               builder: (context) {

                 return Expanded(
                   child: SingleChildScrollView(
                     child: Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                       child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             mode=="variable"? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                   
                                      for(int i=0;i<userRepository.userCar!.length;i++) 
                                        InkWell(
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                           setState(() {
                                              
                                              currentautoId=userRepository.userCar![i].carId;
                                              print(currentautoId);
                                              
                                           });
                                          },
                                          child: VariableCar( pressed:currentautoId==userRepository.userCar![i].carId ,userCar:userRepository.userCar![i],decoreColor: brandBlue,)
                                          ),
                                      if(mode=="variable") Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
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
                                                "+ add vehicle",
                                                style: TextStyle(
                                                  color: brandBlue,
                                                  fontFamily: "SF",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            mode="remove";
                                          });
                                        },
                                        child: SizedBox(
                                          height: 40,
                                          child: Text(
                                            "- remove vehicle",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: "SF",
                                              fontSize: 14,
                                              
                                              fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ),
                                      )
                                        ],
                                      )

                                    ],
                                )
                                :Column(
                                  children: [
                                    for(int i=0;i<userRepository.userCar!.length;i++) 
                                        InkWell(
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                           setState(() {
                                            int findIndex = carIdForRemove.firstWhere((element) => element==userRepository.userCar![i].carId,orElse: () => -1,);
                                              if(findIndex==-1){
                                                carIdForRemove.add(userRepository.userCar![i].carId);
                                              }else{
                                                carIdForRemove=carIdForRemove.where((element) => element!=userRepository.userCar![i].carId).toList();
                                              }
                                              
                                           });
                                          },
                                          child: VariableCar( pressed:carIdForRemove.firstWhere((element) => element==userRepository.userCar![i].carId,orElse: () => -1,)!=-1 ,userCar:userRepository.userCar![i],decoreColor:  Colors.red)
                                          ),
                                  ],
                                ),
                                if(mode=="variable")Padding(
                                           padding: EdgeInsets.only(bottom: 32),
                                            child: InkWell(
                                                              onTap: (){
                                                                int carIndex=userRepository.userCar!.indexWhere((element) => element.carId==currentautoId);
                                                                Navigator.push(
                                                                  context, 
                                                                  MaterialPageRoute(builder: (context) => DopOptions(side: widget.side, preferences: userRepository.userCar![carIndex].preferences , count: userRepository.userCar![carIndex].numberOfSeats, carId: currentautoId,createAuto: false,))
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
                                                                  "Continue",
                                                                  style: TextStyle(
                                            color:Colors.white,
                                            fontFamily: "SF",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600
                                                                  ),
                                                                ),
                                                              ),
                                                            
                                              
                                                          ),
                                          
                                )
                           ],
                         )
                         ,
                     ),
                   ),
                 );
               }
             ),
           ],
         ),
         
       )
           
    );
  }
}



///
///
///
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

