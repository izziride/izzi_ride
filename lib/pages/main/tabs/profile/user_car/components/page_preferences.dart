import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/models/preferences/preferences.dart';
import 'package:temp/pages/UI/app_popup.dart';
import 'package:temp/pages/main/tabs/profile/user_car/provider/provider.dart';



enum VariableType{
  string,int
}

class Page_Preferences extends StatefulWidget {

  const Page_Preferences({super.key});

  @override
  State<Page_Preferences> createState() => _Page_PreferencesState();
}

class _Page_PreferencesState extends State<Page_Preferences> {

  TextEditingController _textController=TextEditingController();

  bool saved=false;




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
    return Padding(
      padding: EdgeInsets.only(left: 15,right: 15),
      child: Consumer<DataProvider>(

        builder: (context, value, child){
          final dataProvider=value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              varibleData("Select the number of available seats",dataProvider.carSeats-1,4,VariableType.int,(int val){
                dataProvider.carSeats=val+1;
              }),
              varibleData("Luggage",dataProvider.luggage?0:1,2,VariableType.string,(bool val){
                dataProvider.luggage=!val;
              }),
              varibleData("Baby chair",dataProvider.childCarSeat?0:1,2,VariableType.string,(bool val){
                dataProvider.childCarSeat=!val;
              }),
              varibleData("Animals",dataProvider.animals?0:1,2,VariableType.string,(bool val){
                dataProvider.animals=!val;
              }),
              varibleData("Smoking",dataProvider.smoking?0:1,2,VariableType.string,(bool val){
                dataProvider.smoking=!val;
              }),
              
            ],
          );
        }
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