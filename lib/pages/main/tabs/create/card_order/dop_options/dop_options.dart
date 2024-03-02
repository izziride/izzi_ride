import 'package:flutter/material.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/http/orders/orders.dart';
import 'package:temp/models/preferences/preferences.dart';
import 'package:temp/pages/UI/app_popup.dart';
import 'package:temp/pages/main/tabs/create/card_order/card_order_redact/card_order_redact.dart';
import 'package:temp/pages/main/tabs/profile/user_car/components/create_modal.dart';
import 'package:temp/repository/user_repo/user_repo.dart';

class PreferencesWithSeats extends Preferences{
  int seats;
  PreferencesWithSeats({required this.seats, required super.smoking, required super.luggage, required super.childCarSeat, required super.animals});
  factory PreferencesWithSeats.combine(Preferences preferences,int seats ){
    return PreferencesWithSeats(
      seats: seats, 
      smoking: preferences.smoking, 
      luggage: preferences.luggage, 
      childCarSeat: preferences.childCarSeat, 
      animals: preferences.animals
    );
  }
}

enum VariableType{
  string,int
}

class ReductDopOptions extends StatefulWidget {
  final int orderId;
    final PreferencesWithSeats preferencesWithSeats;
    final int carId;
    final Function update;
  const ReductDopOptions({required this.update, required this.orderId, required this.carId, required this.preferencesWithSeats, super.key});

  @override
  State<ReductDopOptions> createState() => _ReductDopOptionsState();
}

class _ReductDopOptionsState extends State<ReductDopOptions> {

  TextEditingController _textController=TextEditingController();

  bool saved=false;

  late Preferences _preferences;

  late int _numberSeats;
  late int _animals;
  late int _smoking;
  late int _luggage;
  late int _childSeats;

  setNumberSeats(){
    
  }

  void saveNewData(Preferences preferences)async{
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
              widget.update();
              userRepository.getUserFullInformationOrderWithouOrderId();
              Navigator.pop(context);
            },
            errorFn: (){},
            future: HttpUserOrder().editDriverOrder(
                          widget.carId, 
                          newDataUserOrder!.seats+1, 
                          _textController.text,
                          preferences,
                          widget.orderId
                          ),
          ),
        );
        },
      );
                         
  }


  @override
  void initState() {

    super.initState();
  }
@override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
     print(newDataUserOrder!.preferences.luggage);
    return Padding(
      padding: EdgeInsets.only(left: 15,right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Additional options",
            style: TextStyle(
              color: brandBlack,
              fontFamily: "SF",
              fontSize: 20,
              fontWeight: FontWeight.w700
            ),
          ),
          varibleData("Select the number of available seats",newDataUserOrder!.seats,4,VariableType.int,(int val){newDataUserOrder!.seats=val;}),
          varibleData("Luggage",newDataUserOrder!.preferences.luggage?0:1,2,VariableType.string,(bool val){newDataUserOrder!.preferences.luggage=!val;}),
          varibleData("Baby chair",newDataUserOrder!.preferences.childCarSeat?0:1,2,VariableType.string,(bool val){newDataUserOrder!.preferences.childCarSeat=!val;}),
          varibleData("Animals",newDataUserOrder!.preferences.animals?0:1,2,VariableType.string,(bool val){newDataUserOrder!.preferences.animals=!val;}),
          varibleData("Smoking",newDataUserOrder!.preferences.smoking?0:1,2,VariableType.string,(bool val){newDataUserOrder!.preferences.smoking=!val;}),
          SizedBox(height: 24,),
          Text(
            "Comment on the ride",
            style: TextStyle(
              fontSize: 16,
              fontFamily: "SF",
              fontWeight: FontWeight.w500,
              color: brandBlack
            ),
          ),
          SizedBox(height: 8,),
          
            Container(
              padding: EdgeInsets.all(12,),
              alignment: Alignment.topCenter,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: brandBlue,
                  width: 1,
                  style: BorderStyle.solid
                )
              ),
              child: TextField(
                controller: _textController,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: brandBlack
                      
                    ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    border: InputBorder.none,
                    hintText: "How will you go, do you plan stops, rules of behavior in the car, etc.",
                    hintMaxLines: 2,
                    hintStyle: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color.fromRGBO(119, 119, 119, 1)
                    )
                  ),
              ),
              
            ),
          
          SizedBox(height: 44,),
          InkWell(
            onTap: () {
              showDialog(
                context: context, 
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)
                    ),
                    child: AppPopup(
                      warning: false,
                      title: "Save changes?", 
                      description: "Are you sure you want\nto save the changes?", 
                      pressYes: ()async{
                       
                        Preferences preferences=Preferences(
                          smoking: newDataUserOrder!.preferences.smoking, 
                          luggage: newDataUserOrder!.preferences.luggage, 
                          childCarSeat: newDataUserOrder!.preferences.childCarSeat, 
                          animals: newDataUserOrder!.preferences.animals
                          );
                          Navigator.pop(context);
                          saveNewData(preferences);
                       
                      }, 
                      pressNo: ()=>Navigator.pop(context)
                      ),
                    );
                  
                },
                );
            },
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              height: 60,
              decoration: BoxDecoration(
                color: brandBlue,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Text(
                "Save changes",
                style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white
                    ),
              ),
            ),
          ),
          SizedBox(height: 24)
        ],
      ),
    );
  }

  Widget varibleData(String title,int index,int count,VariableType variableType,Function update ){

    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24,),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontFamily: "SF",
            fontWeight: FontWeight.w500,
            color: brandBlack
          ),
        ),
        SizedBox(height: 8,),
        Row(
          children: [
            for(int i=0;i<count;i++) 
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(32),
                    onTap: () {
                      variableType==VariableType.string?update (i==0?false:true):update(i);
                      
                      setState(() {
                        
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                     
                      width: 56,
                      height: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: i==index?brandBlue:Color.fromRGBO(173, 179, 188, 1),
                          width: 1,
                          style: BorderStyle.solid
                        )
                      ),
                      child: Text(
                        variableType==VariableType.int
                        ? (i+1).toString()
                        : i==0?"Yes":"No",
                        style: TextStyle(
                          color: Color.fromRGBO(85, 85, 85, 1),
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                          fontSize: 16
                        ),
                      ),
                    ),
                  ),
                )
          ],
        )
      ],
    );
  }
}