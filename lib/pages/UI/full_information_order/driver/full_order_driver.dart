import 'package:flutter/material.dart';
import 'package:temp/http/orders/orders.dart';
import 'package:temp/pages/UI/full_information_order/components/booked_status_action_driver.dart';
import 'package:temp/pages/UI/full_information_order/components/booked_status_info.dart';
import 'package:temp/pages/UI/full_information_order/components/info_in_the_map.dart';
import 'package:temp/pages/UI/full_information_order/components/passanger_data.dart';
import 'package:temp/pages/UI/full_information_order/components/ride_details.dart';
import 'package:temp/pages/UI/full_information_order/full_information_order.dart';
import 'package:temp/pages/main/tabs/widgets/card_order.dart';

class CardFullOrderDriver extends StatefulWidget {
  final UserOrderFullInformation userOrderFullInformation;
  final int? chatid;
  final int? seats;
  final String endLocation;
  final String startLocation;
  const CardFullOrderDriver({super.key,required this.userOrderFullInformation,this.chatid,this.seats,required this.startLocation,required this.endLocation});

  @override
  State<CardFullOrderDriver> createState() => _CardFullOrderDriverState();
}

class _CardFullOrderDriverState extends State<CardFullOrderDriver> {
  @override
  Widget build(BuildContext context) {

    DriverOrder driverOrder =  DriverOrder(driverRate: widget.userOrderFullInformation.driverRate,  userId: widget.userOrderFullInformation.userId, orderId: widget.userOrderFullInformation.orderId, clientAutoId: widget.userOrderFullInformation.clientAutoId, departureTime: widget.userOrderFullInformation.departureTime, nickname: widget.userOrderFullInformation.nickname, orderStatus: widget.userOrderFullInformation.orderStatus, startCountryName: widget.startLocation, endCountryName: widget.endLocation, seatsInfo: widget.userOrderFullInformation.seatsInfo, price: widget.userOrderFullInformation.price, preferences: widget.userOrderFullInformation.preferences,bookedStatus: widget.userOrderFullInformation.bookedStatus,status: widget.userOrderFullInformation.status);
    List<Travelers> travelers = widget.userOrderFullInformation.travelers;
    int orderId=widget.userOrderFullInformation.orderId;
    Location startLocation=widget.userOrderFullInformation.location[0];
    Location endLocation=widget.userOrderFullInformation.location[1];
    Automobile automobile = widget.userOrderFullInformation.automobile;
    String comment = widget.userOrderFullInformation.comment??""; 
    int countSeats = widget.userOrderFullInformation.seatsInfo.total;
    bool isCanceled= widget.userOrderFullInformation.bookedStatus=="canceled"||widget.userOrderFullInformation.orderStatus=="canceled";

    return Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 0),
              child: Column(
                children: [
                  FO_BookedStatusInfo(fullUserOrder: widget.userOrderFullInformation,),
                  Opacity(
                    opacity: isCanceled?0.5:1,
                    child: Column(
                      children: [
                        CardOrder(rate: widget.userOrderFullInformation.driverRate, side: (){}, driverOrder: driverOrder,full:true,variable: false,),
                        SizedBox(height:24 ,),
                        FO_PassangerData(travelers:travelers,orderId: orderId,chatid: widget.chatid,),
                        const SizedBox(height: 24,),
                        FO_InfoInTheMap(location:startLocation),
                        const SizedBox(height: 24,),
                        FO_RideDetails(automobile: automobile,comment: comment,countSeats: countSeats,endLocation: endLocation,startLocation: startLocation,),     
                        const SizedBox(height: 24,),
                        FO_BookedStatusActionDriver(fullOrderType: FullOrderType.driver,fullUserOrder: widget.userOrderFullInformation,seats: widget.seats??0,chatid: widget.chatid,)
                      ],
                    ),
                    )
                  
                ],
              ),
            ),
          );
  }
}