import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/models/preferences/preferences.dart';
import 'package:temp/pages/main/tabs/create/auto/auto.dart';
import 'package:temp/pages/main/tabs/create/card_car/card_car.dart';
import 'package:temp/pages/main/tabs/create/dop_options/dop_options.dart';
import 'package:temp/pages/main/tabs/create/enumMap/enum_map.dart';
import 'package:temp/pages/main/tabs/search/result_search/bar_navigation.dart';
import 'package:temp/repository/create_repo/create_repo.dart';


final int defaultcountPass=4;

class AutoTitle extends StatefulWidget{
  const AutoTitle({required this.side, super.key});

  final Function side;

  @override
  State<AutoTitle> createState() => _AutoTitleState();
}

class _AutoTitleState extends State<AutoTitle> {

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

  updateModel(String newModel,int modelId){
    createRepo.updateCarModel(newModel,modelId);
  }

  updateName(String newName,int mnameId){
    createRepo.updateCarNamet(newName,mnameId);
    setState(() {
      
    });
  }

  updateCarNumber(String newNumber){
     createRepo.updateCarNumber(newNumber);
  }

  updateYear(String newYear){
       createRepo.updateCarYear(newYear);
  }
  bool clicked=false;
  bool validManufacturer=true;
  bool validModel=true; 
  bool validNumber=true;
  bool validYear=true;


void checkValid(){
  
  if(createRepo.carName.isEmpty){
    validManufacturer=false;
  }
  if(createRepo.carModel.isEmpty){
    validModel=false;
  }
  if(_numberController.text.isEmpty){
    validNumber=false;
  }
  if(_yearController.text.isEmpty){
    validYear=false;
  }
  setState(() {
    
  });
  if(validManufacturer&&validModel&&validNumber&&validYear){
    createRepo.updateCarNumber(_numberController.text);
    createRepo.updateCarYear(_yearController.text);
    Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DopOptions(side: widget.side, count: defaultcountPass,preferences: Preferences(smoking: false, luggage: false, childCarSeat: false, animals: false),carId: -1,createAuto:true)),
                                );
  }
}

  @override
  Widget build(BuildContext context) {

    return Padding(
          padding: const EdgeInsets.only(top: 20,left: 15,right: 15),
          child: Column(
            
            children: [
              BarNavigation(back: true, title: "Vehicle selection"),
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Observer(
                      builder: (context) {
                        String carName=createRepo.carName;
                        String carModel=createRepo.carModel;
                        int carNameId=createRepo.carNameId;
                        return Column(
                          children: [
                              CardCar(update: updateName, types: MyEnum.name,title:carName,other: "all",valid:validManufacturer,id: -1,),
                              CardCar(update: updateModel, types: MyEnum.model,title:carModel,other: carName,valid:validModel,id: carNameId,),
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
                            color: validNumber?Color.fromRGBO(237, 238, 243, 1):Colors.red
                          )
                                          ),
                                          child: TextField(
                        controller: _numberController,
                        onChanged: (value) {
                          setState(() {
                            validNumber=true;
                          });
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
                          maxLength: 10,
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
                            color: validYear?Color.fromRGBO(237, 238, 243, 1):Colors.red
                          )
                                        ),
                                        child: TextField(
                                          onChanged: (value) {
                                            setState(() {
                                              validYear=true;
                                            });
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
                      }
                    ),
                          Positioned(
                            bottom: 32,
                            left: 0,
                            right: 0,
                            child: InkWell(
                                              onTap: (){
                                               checkValid();
                                               
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
        );
  }
}