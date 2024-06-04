import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/models/car/car.dart';

class VariableCar extends StatelessWidget {
  final bool pressed;
  final UserCar userCar;
  final Color decoreColor;
  const VariableCar({required this.pressed,required this.userCar, super.key,required this.decoreColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      width: double.infinity,
      decoration: BoxDecoration(
                border: Border.all(
                  color:pressed? decoreColor:Color.fromRGBO(233, 235, 238, 1),
                  style: BorderStyle.solid,
                  width: 1
                ),
                borderRadius: BorderRadius.circular(10)
              ),
      height: 74,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
                Padding(
                  padding: const EdgeInsets.only(left:12,right: 16 ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(247, 247, 253, 1),
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: SvgPicture.asset("assets/svg/carSiluete.svg"),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text(
                        userCar.manufacturer,
                        style: TextStyle(
                          color: brandBlack,
                          fontWeight: FontWeight.w700,
                          fontFamily: "SF",
                          fontSize: 16
                        ),
                      ),
                       Text(
                        userCar.model,
                        style: TextStyle(
                          color: brandBlack,
                          fontWeight: FontWeight.w400,
                          fontFamily: "SF",
                          fontSize: 14
                        ),
                      )
                  ],
                )
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: 12),
            width: 24,
            height: 24,
            decoration:BoxDecoration(
             borderRadius: BorderRadius.circular(12),
             border: Border.all(
              color: pressed?decoreColor:Color.fromRGBO(173, 179, 188, 1),
              width: pressed?7:2
             ) 
            ) ,
          )
        ],
      ),
    );
  }
}

class ShimmerVariableCar extends StatelessWidget{
  const ShimmerVariableCar({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(25)
        ),
        width: double.infinity,
        height: 74,
        child: Text("load"),
      ),
    );
  }
}