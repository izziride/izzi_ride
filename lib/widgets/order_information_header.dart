import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/http/orders/orders.dart';
import 'package:temp/pages/UI/dotted_filling.dart';

class OrderInforamationHeader extends StatelessWidget {
  final DriverOrder driverOrder;
  final Function side;
  const OrderInforamationHeader({super.key,required this.driverOrder,required this.side});

  @override
  Widget build(BuildContext context) {

     DateTime dateTime = DateTime.parse(driverOrder.departureTime);
    dateTime=dateTime.add(Duration(hours: DateTime.now().timeZoneOffset.inHours));
    String formattedDate = DateFormat('d MMMM').format(dateTime);
    List<String> dateComponents = formattedDate.split(' ');
    String day = dateComponents[0].padLeft(2, '0');
    String month = dateComponents[1];
    formattedDate = '$day $month';

    String formattedTime = DateFormat('HH:mm').format(dateTime);
    formattedTime = formattedTime.split(':').map((segment) => segment.padLeft(2, '0')).join(':');

    NumberFormat formatter = NumberFormat('###,###.00\$','ru_RU');
    formatter.minimumFractionDigits = 2;
    formatter.maximumFractionDigits = 2;
    
    String formattedNumber = formatter.format(driverOrder.price);


    return   Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                spreadRadius: 0,
                blurRadius: 50,
                offset: Offset(0, 10), 
              ),
        ],
          ),
          
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          child: Column(
             children: [
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                children: [
                  ////1ый 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: cardSearchGray
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 4,vertical: 2),
                            child: Text(
                              formattedDate,
                              style: const TextStyle(
                                fontFamily: "SF",
                                fontSize: 8,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(51, 51, 51, 1)
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 4)),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: cardSearchGray
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 4,vertical: 2),
                            child: Text(
                              formattedTime,
                              style: const TextStyle(
                                fontFamily: "SF",
                                fontSize: 8,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(51, 51, 51, 1)
                              ),
                            ),
                          ),
                        ],
                      ),
                       Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          driverOrder.startCountryName,
                          style: TextStyle(
                                fontFamily: "SF",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(51, 51, 51, 1)
                          ),
                        ),
                      )
                    ],
                  ),
                  ///1ый
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 13,right: 13),
                      child: SizedBox(
                          height: 30,
                          width: double.infinity,
                        child: CustomPaint(
                          
                          painter: DottedFeeling(
                            color: const Color.fromRGBO(217,217,217,1),
                            dotSize: 2,
                            spacing: 2
                          ),
                        ),
                      ),
                    ),
                  ),
                  ///////3ый 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 14,
                        
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:4),
                        child: Text(
                          driverOrder.endCountryName,
                          style: TextStyle(
                                fontFamily: "SF",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(51, 51, 51, 1)
                          ),
                        ),
                      )
                    ],
                  )
                  ///3ый
                ],
              ),
              Padding(padding: EdgeInsets.only(top:16)),
              Container(
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: cardSearchGray
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8,right: 7),
                          child: Container(
                              height: 40,
                              width: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(214, 214, 216, 1),
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Text(
                                driverOrder.nickname.isNotEmpty == true ? driverOrder.nickname[0] : "!",
                                style: const TextStyle(
                                      fontFamily: "SF",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white
                                ),
                              ),
                          ),
                        ),
                        Text(
                          driverOrder.nickname,
                          style: const TextStyle(
                                      fontFamily: "SF",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(51, 51, 51, 1)
                                ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text(
                        formattedNumber,
                        style: const TextStyle(
                            fontFamily: "SF",
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(51, 51, 51, 1)
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Free places",
                      style: const TextStyle(
                            fontFamily: "SF",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(51, 51, 51, 1)
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            for (int i = 0; i < driverOrder.seatsInfo.reserved; i++) Padding(
                              padding: const EdgeInsets.only(right: 5.7),
                              child: SvgPicture.asset("assets/svg/passenger.svg"),
                            ),
                            for (int i = 0; i < driverOrder.seatsInfo.free; i++) Padding(
                              padding: const EdgeInsets.only(right: 5.7),
                              child: SvgPicture.asset("assets/svg/passanger_empty.svg"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.17),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SvgPicture.asset("assets/svg/childSeats.svg",color:driverOrder.preferences.childCarSeat?Color.fromRGBO(64,123,255,1):Color.fromRGBO(173,179,188,1) ,),
                                  driverOrder.preferences.childCarSeat?SizedBox.shrink():Icon(Icons.close,size: 30,weight: 1,color: Color.fromARGB(255, 169, 108, 104) ,)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.17),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SvgPicture.asset("assets/svg/animals.svg",color:driverOrder.preferences.animals?Color.fromRGBO(64,123,255,1):Color.fromRGBO(173,179,188,1) ,),
                                  driverOrder.preferences.animals?SizedBox.shrink():Icon(Icons.close,size: 30,weight: 2,color: Color.fromARGB(255, 169, 108, 104)  ,)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.17),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SvgPicture.asset("assets/svg/luggage.svg",color:driverOrder.preferences.luggage?Color.fromRGBO(64,123,255,1):Color.fromRGBO(173,179,188,1) ,),
                                  driverOrder.preferences.luggage?SizedBox.shrink():Icon(Icons.close,size: 30,weight: 2,color: Color.fromARGB(255, 169, 108, 104)  ,)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 0),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SvgPicture.asset("assets/svg/smoking.svg",color:driverOrder.preferences.smoking?Color.fromRGBO(64,123,255,1):Color.fromRGBO(173,179,188,1) ,),
                                  driverOrder.preferences.smoking?SizedBox.shrink():Icon(Icons.close,size: 30,weight: 2,color: Color.fromARGB(255, 169, 108, 104)  ,)
                                ],
                              ),
                            ),

                          ],
                        )
                      ],
                    ),

                  ],
                ),
              ),
              InkWell(
                // onTap: () {
                //   Navigator.push(context, MaterialPageRoute(builder: (context) => CardFullOrder(
                //     side: (){
                //       side();
                //     },
                //     fullOrderType: FullOrderType.driver,
                //     startLocation: driverOrder.startCountryName,
                //     endLocation: driverOrder.endCountryName,
                //     orderId:driverOrder.orderId
                //   ),));
                // },
                child: Container(
                  margin: EdgeInsets.only(top:13),
                        height: 48,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(242, 243, 245, 1),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text(
                          "Details",
                          style: TextStyle(
                            color: Color.fromRGBO(64, 123, 255, 1),
                            fontFamily: "Inter",
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
              ),
             ],
          ),
        ),
      
    );
  }
}