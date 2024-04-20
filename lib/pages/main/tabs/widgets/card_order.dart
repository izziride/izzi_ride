
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/http/orders/orders.dart';
import 'package:temp/pages/UI/full_information_order/full_information_order.dart';

class CardOrder extends StatelessWidget{
final DriverOrder driverOrder;
final Function side;
final bool full;
final bool variable;
final double rate;
const CardOrder({required this.rate, required this.variable, required this.side, required this.driverOrder,required this.full,super.key});

  @override
  Widget build(BuildContext context) {
    print("ored");
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
    
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
      child: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
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
              height:full? 214:262,
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  Column(
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
                                   driverOrder.startCountryName[0].toUpperCase()+ driverOrder.startCountryName.substring(1),
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
                                    
                                    painter: DottedLinePainter(
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
                                   driverOrder.endCountryName[0].toUpperCase()+ driverOrder.endCountryName.substring(1),
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
                                          driverOrder.nickname.isNotEmpty ? driverOrder.nickname[0] : "!",
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
                                  ),
                                  SizedBox(width: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${rate}",
                                        style: TextStyle(
                                          color: Color.fromRGBO(51, 51, 51, 1),
                                          fontFamily: "Inter",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      Icon(Icons.star,size: 20,color: Color.fromARGB(255, 240, 217, 11))
                                    ],
                                ),
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
                          padding: EdgeInsets.only(top:16,bottom: 13),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Seats",
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
                              )
                            ],
                          ),
                        ),
                        
                       ],
                  
                  ),
                  !full? InkWell(
                    onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => CardFullOrder(
                        side: (){},
                        fullOrderType: FullOrderType.user,
                        startLocation: driverOrder.startCountryName,
                        endLocation: driverOrder.endCountryName,
                        orderId:driverOrder.orderId,
                        seats: 4,
                      ),));
                    
                    },
                    child: Container(
                          height: 48,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(242, 243, 245, 1),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text(
                            "Ride details",
                            style: TextStyle(
                              color: Color.fromRGBO(64, 123, 255, 1),
                              fontFamily: "Inter",
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                  ):SizedBox.shrink()
                ],
              ),
            
          ),
          variable?Container(
              height:full? 214:262,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromRGBO(136, 148, 173, 0.836),
                borderRadius: BorderRadius.circular(12)
              ),
              child: Center(
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(driverOrder.bookedStatus=="unbooked"?Icons.info: Icons.done,size:  40,),
                    (driverOrder.bookedStatus!="unbooked"&&driverOrder.status!="finished")
                    ?Text(
                            "You are a participant in the trip.\nCan't hide.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: brandBlue,
                              fontFamily: "SF",
                              fontSize: 18,
                              fontWeight: FontWeight.w800
                            ),
                          ):SizedBox.shrink(),
                  ],
                )
              ),
          ):SizedBox.shrink()
        ],
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  final Color color;
  final double dotSize;
  final double spacing;

  DottedLinePainter({required this.color, required this.dotSize, required this.spacing});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final dotRadius = dotSize / 2;
    final dotSpacing = dotSize + spacing;
    final dotsCount = (size.width / dotSpacing).ceil();
    final lineWidth = dotSpacing * (dotsCount - 1) + dotSize;

    final startX = (size.width - lineWidth) / 2;
    final startY = size.height / 2;

    for (var i = 0; i < dotsCount; i++) {
      final dotCenter = Offset(startX + dotSpacing * i + dotRadius, startY);
      canvas.drawCircle(dotCenter, dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}