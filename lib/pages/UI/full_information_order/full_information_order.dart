import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:map_launcher/map_launcher.dart' as Launcher;
import 'package:string_to_color/string_to_color.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/http/chats/http_chats.dart';
import 'package:temp/http/orders/orders.dart';
import 'package:temp/pages/UI/app_popup.dart';
import 'package:temp/pages/UI/full_information_order/client/full_order_client.dart';
import 'package:temp/pages/UI/full_information_order/components/booked_status_action_driver.dart';
import 'package:temp/pages/UI/full_information_order/components/booked_status_info.dart';
import 'package:temp/pages/UI/full_information_order/components/info_in_the_map.dart';
import 'package:temp/pages/UI/full_information_order/components/passanger_data.dart';
import 'package:temp/pages/UI/full_information_order/components/ride_details.dart';
import 'package:temp/pages/UI/full_information_order/driver/full_order_driver.dart';
import 'package:temp/pages/main/tabs/chat/chat_page.dart';
import 'package:temp/pages/main/tabs/create/card_order/card_order_redact/card_order_redact.dart';
import 'package:temp/pages/main/tabs/search/result_search/bar_navigation.dart';
import 'package:temp/pages/main/tabs/widgets/card_order.dart';
import 'package:temp/repository/user_repo/user_repo.dart';
enum FullOrderType{
  driver,user,none
}
class CardFullOrder extends StatefulWidget{
  final int? seats;
  final FullOrderType? fullOrderType;
  final Function side;
  int? chatid=null;
  CardFullOrder({this.chatid, required this.side, this.seats, this.fullOrderType, required this.startLocation,required this.endLocation,required this.orderId, super.key});

  final String endLocation;
  final int orderId;
  final String startLocation;

  @override
  State<CardFullOrder> createState() => _CardFullOrderState();
}

class _CardFullOrderState extends State<CardFullOrder> {




  

 

  @override
  void dispose() {
    userRepository.userOrderFullInformation=null;
    userRepository.userOrderFullInformationError=false;
    print("dis");
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          BarNavigation(back: true, title: "${widget.startLocation[0].toUpperCase()+widget.startLocation.substring(1)} - ${widget.endLocation[0].toUpperCase()+widget.endLocation.substring(1)}"),
          Observer(
            builder: (context) {
              if(userRepository.userOrderFullInformation==null){
                userRepository.getUserFullInformationOrder(widget.orderId);
                return CircularProgressIndicator();
              }
              if(userRepository.userOrderFullInformationError){
                return Center(
                    child: Text("error"),
                  );
              }
              UserOrderFullInformation fullUserOrder=userRepository.userOrderFullInformation!;
              FullOrderType fullOrderType=fullUserOrder.isDriver? FullOrderType.driver:FullOrderType.user;
              if(fullOrderType==FullOrderType.driver){
                return CardFullOrderDriver(userOrderFullInformation: fullUserOrder,chatid: widget.chatid,startLocation: widget.startLocation,endLocation: widget.endLocation,);
              }else if(fullOrderType==FullOrderType.user){
                CardFullOrderClient();
              }
              

              DriverOrder driverOrder =  DriverOrder(driverRate: fullUserOrder.driverRate,  userId: fullUserOrder.userId, orderId: fullUserOrder.orderId, clientAutoId: fullUserOrder.clientAutoId, departureTime: fullUserOrder.departureTime, nickname: fullUserOrder.nickname, orderStatus: fullUserOrder.orderStatus, startCountryName: widget.startLocation, endCountryName: widget.endLocation, seatsInfo: fullUserOrder.seatsInfo, price: fullUserOrder.price, preferences: fullUserOrder.preferences,bookedStatus: fullUserOrder.bookedStatus,status: fullUserOrder.status);
              List<Travelers> travelers = fullUserOrder.travelers;
              int orderId=fullUserOrder.orderId;
              Location startLocation=fullUserOrder.location[0];
              Location endLocation=fullUserOrder.location[1];
              Automobile automobile = fullUserOrder.automobile;
              String comment = fullUserOrder.comment??""; 
              int countSeats = fullUserOrder.seatsInfo.total;
              bool isCanceled= fullUserOrder.bookedStatus=="canceled"||fullUserOrder.orderStatus=="canceled";
              return Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 0),
                    child: Column(
                      children: [
                        FO_BookedStatusInfo(fullUserOrder: fullUserOrder,),
                        Opacity(
                          opacity: isCanceled?0.5:1,
                          child: Column(
                            children: [
                              CardOrder(rate: fullUserOrder.driverRate, side: (){}, driverOrder: driverOrder,full:true,variable: false,),
                              SizedBox(height: fullOrderType==FullOrderType.driver?24:0 ,),
                              fullOrderType==FullOrderType.driver?FO_PassangerData(travelers:travelers,orderId: orderId,chatid: widget.chatid,orderStatus:driverOrder.orderStatus ,):const SizedBox.shrink(),
                              const SizedBox(height: 24,),
                              FO_InfoInTheMap(location:startLocation),
                              const SizedBox(height: 24,),
                              FO_RideDetails(automobile: automobile,comment: comment,countSeats: countSeats,endLocation: endLocation,startLocation: startLocation,),     
                              const SizedBox(height: 24,),
                              FO_BookedStatusActionDriver(fullOrderType: fullOrderType,fullUserOrder: fullUserOrder,seats: widget.seats??0,chatid: widget.chatid,)
                            ],
                          ),
                          )
                        
                      ],
                    ),
                  ),
                );
            },
            )
         
        ],
      ),
    );
  }
}


class DashedLineWidget extends StatelessWidget {
  const DashedLineWidget({super.key, required this.windowWidth});

  final double windowWidth;

  @override
  Widget build(BuildContext context) {
    //18*C+190=windowWidth N=10
    double w=(windowWidth-95)/18;

    //int count=windowWidth ~/20;
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Row(
        
        children: [
            for (int i = 0; i < 18; i++) Container(
                width:w,
                height: 1.5,
                margin: EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
    
                  color: brandBlue,
                  borderRadius: BorderRadius.circular(10)
                ),
            )
        ],
      ),
    );
  }
}

