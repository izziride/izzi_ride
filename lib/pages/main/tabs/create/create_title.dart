
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp/http/orders/orders.dart';
import 'package:temp/pages/main/tabs/create/UI/card_coordinates.dart';
import 'package:temp/pages/main/tabs/create/auto/auto.dart';
import 'package:temp/pages/main/tabs/search/UI/calendare/calendare.dart';
import 'package:temp/pages/main/tabs/search/UI/time_picker/time_picker.dart';
import 'package:temp/pages/main/tabs/search/result_search/bar_navigation.dart';
import 'package:temp/repository/create_repo/create_repo.dart';

class CreateTitle extends StatefulWidget{
  final Function side;
  final bool back;
  const CreateTitle({required this.side, required this.back, super.key});

  @override
  State<CreateTitle> createState() => _CreateTitle();
}

class _CreateTitle extends State<CreateTitle> {

  DateTime date=DateTime.now();

  bool isFromEmpty=false;
  bool isToEmpty=false;

  void updateDate(DateTime newDate){
    setState(() {
      date=newDate;
      createRepo.updateDate(date);
    });
  }

  DateTime time=DateTime.now();
  void updateTime(DateTime newTime){
    setState(() {
      createRepo.updateTime(newTime);
      time=newTime;
    });
  }



void _showDialogPage(BuildContext context){
  
   if(createRepo.fromCity.isEmpty){
      setState(() {
        isFromEmpty=true;
      });
    }
    if(createRepo.toCity.isEmpty){
      setState(() {
        isToEmpty=true;
      });
    }
    if(!isFromEmpty&&!isToEmpty){
  

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>  Auto(side: widget.side )),
      
      );
    }
  
}
  @override
  void initState() {
    
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {


    
  double winWidth=MediaQuery.of(context).size.height;
  double imageKF=0.5;
  print(winWidth);
  if(winWidth<700){
    imageKF=0.3;
  }
    return  Column(
            children: [
              BarNavigation(back: widget.back, title: "Create a ride to find a ridemate",),
              Image.asset("assets/image/my_trips.png",width: winWidth*imageKF,),
               Expanded(
                 child: Padding(
                    padding: const EdgeInsets.only(top:12, left: 15,right: 15,),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Observer(
                                builder: (context) {
                                  return CardCoordinates(
                                    valid:!isFromEmpty,
                                  hint: "From",
                                  name: createRepo.fromCity,
                                  icon: SvgPicture.asset(
                                        "assets/svg/geoFrom.svg"
                                        ),
                                  update: (String city,String state,double lat,double lng,String fullAddress){
                                    setState(() {
                                      isFromEmpty=false;
                                    });
                                      createRepo.updateFromCity(city);
                                      createRepo.updateFromState(state);
                                      createRepo.updateFromLat(lat);
                                      createRepo.updateFromLng(lng);
                                      createRepo.fromFullAddress=fullAddress;
                                  },
                                );
                                },
                                
                              ),
                            ),
                          Observer(
                            builder: (context) {
                              return CardCoordinates(
                                valid:!isToEmpty,
                              hint: "To",
                              name: createRepo.toCity,
                              icon: SvgPicture.asset(
                                    "assets/svg/geoTo.svg"
                                    ),
                              update: (String city,String state,double lat,double lng,String fullAddress){
                                 setState(() {
                                      isToEmpty=false;
                                    });
                                    createRepo.updateToCity(city);
                                      createRepo.updateToState(state);
                                      createRepo.updateToLat(lat);
                                      createRepo.updateToLng(lng);
                                      createRepo.toFullAddress=fullAddress;
                              },
                            );
                            },
                            
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:12,bottom: 12),
                            child: Calendare(updateDate: updateDate, date: date),
                          ),
                            TimePicker(time: time,updateTime: updateTime,),
                          ],
                        ),
                        
                      
                             //Text("323 ${Provider.of<CreateProvider>(context).price}"),
                  
                  Positioned(
                    bottom: 24,
                    left: 0,
                    right: 0,
                    child: Padding(
                        padding: const EdgeInsets.only(top:10),
                        child: InkWell(
                          onTap: (){
                            _showDialogPage(context);
                          },
                          child: Observer(
                            builder: (context) {
                              return Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                color: createRepo.fromCity!=""&&createRepo.toCity!=""?const Color.fromRGBO(64,123,255,1):const Color.fromRGBO(177,177,177,0.5),
                                borderRadius: BorderRadius.circular(10)
                                
                              ),
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                  color: createRepo.fromCity!=""&&createRepo.toCity!=""?const Color.fromRGBO(255,255,255,1):const Color.fromRGBO(255,255,255,0.5),
                                  fontFamily: "Inter",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            );
                            },
                             
                          ),
                        ),
                      ),
                  )
                      ],
                    ),
                  ),
               ),
              
              
            ],
          );

  }
}