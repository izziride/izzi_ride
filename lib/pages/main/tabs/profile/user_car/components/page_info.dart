import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/pages/main/tabs/create/auto/auto.dart';
import 'package:temp/pages/main/tabs/create/card_car/card_car.dart';
import 'package:temp/pages/main/tabs/create/enumMap/enum_map.dart';
import 'package:temp/pages/main/tabs/profile/user_car/provider/provider.dart';

class Page_InfoCar extends StatefulWidget {
  final FocusNode numberFocusNode;
  final FocusNode yearFocusNode;
  const Page_InfoCar({super.key,required this.numberFocusNode,required this.yearFocusNode});


  @override
  State<Page_InfoCar> createState() => _Page_InfoCarState();
}

class _Page_InfoCarState extends State<Page_InfoCar> {

  
  late TextEditingController _numberController;
  late TextEditingController _yearController;


  

  @override
  void dispose() {
    _yearController.dispose();
    _numberController.dispose();
    super.dispose();
  }

@override
  void initState() {
    _yearController =TextEditingController();
  _numberController =TextEditingController();
    super.initState();
  }


  bool clicked=false;



// void checkValid()async{
  
//   if(carName.isEmpty){
//     validManufacturer=false;
//   }
//   if(carModel.isEmpty){
//     validModel=false;
//   }
//   if(_numberController.text.isEmpty){
//     validNumber=false;
//   }
//   if(_yearController.text.isEmpty){
//     validYear=false;
//   }
//   setState(() {
    
//   });
//   if(validManufacturer&&validModel&&validNumber&&validYear){
//     // createRepo.updateCarNumber(_numberController.text);
//     // createRepo.updateCarYear(_yearController.text);
//   //   ClientCar clientCar=ClientCar(modelId: carModelId, manufacturerId: carNameId, numberOfSeats: numberOfSeats, autoNumber: autoNumber, year: year, preferences: preferences)
//   //  int result=await HttpUserCar().createUserCar(clientCar);
//   }
// }


  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) {
        final dataProvider=value;
        print(value.validManufacturer);
        return Column(
                children: [
                  CardCar(update: dataProvider.updateName, types: MyEnum.name,title:dataProvider.carName,other: "all",valid:dataProvider.validManufacturer,id: -1,),
                  CardCar(update: dataProvider.updateModel, types: MyEnum.model,title:dataProvider.carModel,other: dataProvider.carName,valid:dataProvider.validModel,id: dataProvider.carNameId,),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    alignment: Alignment.center,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: categorySelected,
                      border: Border.all(
                          color: dataProvider.validNumber?Color.fromRGBO(237, 238, 243, 1):Colors.red
                      )
                    ),
                    child: TextField(
                      focusNode: widget.numberFocusNode,
                      controller: _numberController,
                      onChanged: (value) {
                         dataProvider.updateCarNumber(value);
                        dataProvider.validNumber=true;
                      },
                      style: TextStyle(
                        fontFamily: "SF",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: brandBlack
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Plate number of the vehicle",
                        counterText: ""
                      ),
                      inputFormatters: [
                        UpperCaseTextFormatter()
                      ],
                      maxLength: 7,
                      textCapitalization: TextCapitalization.sentences
                    ),
                    ),
                  ),
                        Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                alignment: Alignment.center,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: categorySelected,
                                  border: Border.all(
                  color: dataProvider.validYear?Color.fromRGBO(237, 238, 243, 1):Colors.red
                )
                              ),
                              child: TextField(
                                focusNode: widget.yearFocusNode,
                                onChanged: (value) {
                                  dataProvider.updateYear(value);
                                 dataProvider.validYear=true;
                                },
                                controller: _yearController,
                                  style: TextStyle(
                fontFamily: "SF",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: brandBlack
              ),
                                decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Year of manufacture of the vehicle",
              counterText: ""
                                ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), 
              ],
              maxLength: 4,
                              ),
                    ),
                ],
              );
      },
      
    );
  }
}