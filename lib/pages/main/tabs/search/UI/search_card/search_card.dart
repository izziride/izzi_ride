
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/http/orders/orders.dart';

class CardsearchOrder extends StatefulWidget{
DriverOrderFind driverOrder;
CardsearchOrder({required this.driverOrder, super.key});

  @override
  State<CardsearchOrder> createState() => _CardsearchOrder();
}

class _CardsearchOrder extends State<CardsearchOrder> {
  @override
  Widget build(BuildContext context) {

    DateTime dateTime = DateTime.parse(widget.driverOrder.departureTime);
    dateTime= dateTime.add(Duration(hours: DateTime.now().timeZoneOffset.inHours));
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
    
    String formattedNumber = formatter.format(widget.driverOrder.price);

    return Padding(
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
        height: 193,
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
                        widget.driverOrder.startPoint.city,
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
                        widget.driverOrder.endPoint.city,
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
                              widget.driverOrder.nickname.isNotEmpty == true ? widget.driverOrder.nickname[0] : "!",
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
                        widget.driverOrder.nickname,
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
                          for (int i = 0; i < widget.driverOrder.seatsInfo.reserved; i++) Padding(
                            padding: const EdgeInsets.only(right: 5.7),
                            child: SvgPicture.asset("assets/svg/personSeats.svg"),
                          ),
                          for (int i = 0; i < widget.driverOrder.seatsInfo.free; i++) Padding(
                            padding: const EdgeInsets.only(right: 5.7),
                            child: SvgPicture.asset("assets/svg/personEmptySeats.svg"),
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
                                SvgPicture.asset("assets/svg/childSeats.svg",color:widget.driverOrder.preferences.childCarSeat?Color.fromRGBO(64,123,255,1):Color.fromRGBO(173,179,188,1) ,),
                                widget.driverOrder.preferences.childCarSeat?SizedBox.shrink():Icon(Icons.close,size: 30,weight: 1,color: Color.fromARGB(255, 169, 108, 104) ,)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.17),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SvgPicture.asset("assets/svg/animals.svg",color:widget.driverOrder.preferences.animals?Color.fromRGBO(64,123,255,1):Color.fromRGBO(173,179,188,1) ,),
                                widget.driverOrder.preferences.animals?SizedBox.shrink():Icon(Icons.close,size: 30,weight: 2,color: Color.fromARGB(255, 169, 108, 104)  ,)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.17),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SvgPicture.asset("assets/svg/luggage.svg",color:widget.driverOrder.preferences.luggage?Color.fromRGBO(64,123,255,1):Color.fromRGBO(173,179,188,1) ,),
                                widget.driverOrder.preferences.luggage?SizedBox.shrink():Icon(Icons.close,size: 30,weight: 2,color: Color.fromARGB(255, 169, 108, 104)  ,)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SvgPicture.asset("assets/svg/smoking.svg",color:widget.driverOrder.preferences.smoking?Color.fromRGBO(64,123,255,1):Color.fromRGBO(173,179,188,1) ,),
                                widget.driverOrder.preferences.smoking?SizedBox.shrink():Icon(Icons.close,size: 30,weight: 2,color: Color.fromARGB(255, 169, 108, 104)  ,)
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
           ],
        ),
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