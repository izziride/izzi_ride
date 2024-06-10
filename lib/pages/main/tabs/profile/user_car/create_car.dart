import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/http/user/http_user_car.dart';
import 'package:temp/models/car/car.dart';
import 'package:temp/models/preferences/preferences.dart';
import 'package:temp/pages/main/tabs/create/auto/auto.dart';
import 'package:temp/pages/main/tabs/create/card_car/card_car.dart';
import 'package:temp/pages/main/tabs/create/enumMap/enum_map.dart';
import 'package:temp/pages/main/tabs/profile/user_car/components/create_modal.dart';
import 'package:temp/pages/main/tabs/profile/user_car/components/page_info.dart';
import 'package:temp/pages/main/tabs/profile/user_car/components/page_preferences.dart';
import 'package:temp/pages/main/tabs/profile/user_car/drivers/drivers.dart';
import 'package:temp/pages/main/tabs/profile/user_car/provider/provider.dart';
import 'package:temp/pages/main/tabs/search/result_search/bar_navigation.dart';
import 'package:temp/repository/user_repo/user_repo.dart';

class CreateCar extends StatefulWidget {
  const CreateCar({super.key});

  @override
  State<CreateCar> createState() => _CreateCarState();
}

class _CreateCarState extends State<CreateCar> {

  final PageController _pageController=PageController();
  UserCarDrivers _userCarDrivers=UserCarDrivers();

  int step=0;


  createCar(ClientCar clientCar ){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child: CreateModal(
            completed: (){
              userRepository.getUserCar();
              Navigator.pop(context);
            },
            errorFn: (){},
            future: HttpUserCar().createUserCar(clientCar),
          ),
        );
      },
      );
      //HttpUserCar().createUserCar(clientCar)
  }




  void checkValid(BuildContext context){
    final dataProvider=context.read<DataProvider>();
    if(step==0){
     
      if(dataProvider.carName.isEmpty){
        dataProvider.validManufacturer=false;
      }
      if(dataProvider.carModel.isEmpty){
        dataProvider.validModel=false;
      }
      if(dataProvider.carNumber.isEmpty){
        dataProvider.validNumber=false;
      }
      
      if(dataProvider.carYear.isEmpty){
        dataProvider.validYear=false;
      }else{
        int year=int.parse(dataProvider.carYear);
        if(year<1900||year>DateTime.now().year){
          dataProvider.validYear=false;
        }
      }
      if(
        dataProvider.validManufacturer&&
        dataProvider.validModel&&
        dataProvider.validNumber&&
        dataProvider.validYear
      ){
        _userCarDrivers.numberFocusNode.unfocus();
        _userCarDrivers.yearFocusNode.unfocus();
         _pageController.animateToPage(step+1, duration: Duration(milliseconds: 400), curve: Curves.linear);
      }
    }
    if(step==1){
      Preferences pref=Preferences(
        smoking: dataProvider.smoking, 
        luggage: dataProvider.luggage, 
        childCarSeat: dataProvider.childCarSeat, 
        animals: dataProvider.animals
      );
      ClientCar clientCar=ClientCar(
        modelId: dataProvider.carModelId, 
        manufacturerId: dataProvider.carNameId, 
        numberOfSeats: dataProvider.carSeats, 
        autoNumber: dataProvider.carNumber, 
        year: dataProvider.carYear, 
        preferences: pref
        );
      createCar(clientCar);
    }
  }

  @override
  void dispose() {
    _userCarDrivers.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body:Padding(
          padding: const EdgeInsets.only(top: 20,left: 15,right: 15),
          child:  Column(
              
              children: [
                BarNavigation(back: true, title: "Add a new vehicle"),
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                            PageView.builder(
                              controller: _pageController,
                              onPageChanged: (value) {
                                setState(() {
                                  step=value;
                                });
                              },
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  //print(context.read<DataProvider>().validModel.toString()+"//////////");
                                  switch(index){
                                    case 0: return Page_InfoCar(
                                      numberFocusNode: _userCarDrivers.numberFocusNode,
                                      yearFocusNode: _userCarDrivers.yearFocusNode,
                                    );
                                    case 1: return Page_Preferences();
                                  }
                                  return SizedBox.shrink();
                                },
                                ),
                        
                            Positioned(
                              bottom: 32,
                              left: 0,
                              right: 0,
                              child: InkWell(
                                                onTap: (){
                                                checkValid(context);
                                                 
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
                                                    step==0?"Continue":"Create",
                                                    style: TextStyle(
                              color:Colors.white,
                              fontFamily: "Inter",
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                                                    ),
                                                  ),
                                                ),
                                              
                                
                                            ),
                            )
                    ],
                  ),
                ),
                
            
              ],
            ),
          
        )
    );
  }
}