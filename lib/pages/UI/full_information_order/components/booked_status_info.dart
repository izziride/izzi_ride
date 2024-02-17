import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/http/chats/http_chats.dart';
import 'package:temp/http/orders/orders.dart';
import 'package:temp/pages/UI/app_popup.dart';
import 'package:temp/pages/UI/full_information_order/full_information_order.dart';
import 'package:temp/pages/main/tabs/chat/chat_page.dart';
import 'package:temp/pages/main/tabs/create/card_order/card_order_redact/card_order_redact.dart';
import 'package:temp/repository/user_repo/user_repo.dart';

class FO_BookedStatusInfo extends StatefulWidget {
  final UserOrderFullInformation fullUserOrder;
  const FO_BookedStatusInfo({
    super.key,
    required this.fullUserOrder
    });

  @override
  State<FO_BookedStatusInfo> createState() => _FO_BookedStatusInfoState();
}

class _FO_BookedStatusInfoState extends State<FO_BookedStatusInfo> {

  bool tapBlocked=false;
   void update(){
    setState(() {
      
    });
  }
  List<Widget> infoByStatus= [];

  @override
  Widget build(BuildContext context) {
    String bookedStatus=widget.fullUserOrder.bookedStatus;
    String orderStatus=widget.fullUserOrder.orderStatus;
    print(bookedStatus);
    if(orderStatus=="canceled"){
      infoByStatus.add(orderStatusCanceled());
    }
     if(bookedStatus=="canceled"){
      infoByStatus.add(bookedStatusCanceled());
    }
    return Column(
      children: infoByStatus,
    );
  }

  Widget bookedStatusCanceled(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width-30,
      decoration: BoxDecoration(
        color: Color.fromARGB(175, 253, 52, 38),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.red,
          width: 2
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Align(
            alignment: Alignment.center,
             child: Text(
                "You were excluded from the trip",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: "SF",
                  fontWeight: FontWeight.w600,
                  fontSize: 16
                ),
              ),
           ),
            SizedBox(height: 20,),
            Text(
              " Сomment:",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: "SF",
                fontWeight: FontWeight.w400,
                fontSize: 14
              ),
            ),
        ],
      ),
    );
  }

  Widget orderStatusCanceled(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width-30,
      decoration: BoxDecoration(
        color: Color.fromARGB(176, 238, 84, 73),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.red,
          width: 2
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Align(
            alignment: Alignment.center,
             child: Text(
                "Driver cancel order",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: "SF",
                  fontWeight: FontWeight.w600,
                  fontSize: 16
                ),
              ),
           ),
            SizedBox(height: 20,),
            Text(
              " Comment:",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: "SF",
                fontWeight: FontWeight.w400,
                fontSize: 14
              ),
            ),
        ],
      ),
    );
  }

}