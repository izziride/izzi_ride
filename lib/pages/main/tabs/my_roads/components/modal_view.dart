import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/http/orders/orders.dart';
import 'package:temp/repository/user_repo/user_repo.dart';

class MyRoadActionModal extends StatefulWidget {
  final DriverOrder order;
  final double dy;
  final Function() close;
  const MyRoadActionModal({super.key,required this.dy,required this.order,required this.close});

  @override
  State<MyRoadActionModal> createState() => _MyRoadActionModalState();
}

class _MyRoadActionModalState extends State<MyRoadActionModal> {
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    print(widget.dy);
    double dyPosition=widget.dy<120?10:widget.dy-110;
    return  Stack(
      children: [
        
        Positioned(
          top: dyPosition,
          left: 10,
          
          child: Stack(
            children: [
              SizedBox(
                      width: 150,
                      height: 80,
                      child:  ClipRRect(
                         borderRadius: BorderRadius.circular(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                              children: [
                                item("Hide order","delete"),
                                item("Cancel order","cancel_booking")
                              ],
                            ),
                      ),
              ),
              Positioned(
                bottom: 0,
                right: 7,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                  child: CustomPaint(
                    painter: RoundedSquarePainter(15),
                  ),
                )
                ),
            ],
          ),
        ),
        
      ],
    );
  }

  actionDispatcher(String action)async{
    if(action=="delete"){
      
     int statusCode= await  HttpUserOrder().hideOrderBooking(widget.order.orderId);
     print(statusCode);
     if(statusCode==129){
      await  HttpUserOrder().orderCancel(widget.order.orderId);
      await userRepository.getUserBookedOrders();
     }else{
      await userRepository.getUserBookedOrders();
     }
      return widget.close();
    
    }
    if(action=="cancel_booking"){
      return;
    }
  }

  Widget item(String text,String action){
    return GestureDetector(
      onTap: () {
        actionDispatcher(action);
      },
      child: SizedBox(
        height: 40,
        width: 150,
        child: ColoredBox(
          color: brandBlue,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                text,
                style: const TextStyle(
              fontFamily: "SF",
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.white
                    ),
              ),
            ),
          ),
          ),
      ),
    );
  }
}


class RoundedSquarePainter extends CustomPainter {
  final double radius;

  RoundedSquarePainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = brandBlue
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..arcToPoint(
        Offset(size.width-7, size.height - radius),
        radius: Radius.circular(radius),
        clockwise: false,
      )
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}