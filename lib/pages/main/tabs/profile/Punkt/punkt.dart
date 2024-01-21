
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Punkt extends StatelessWidget   {
 final String punkt;
 final Function onTap;
 final bool? warning;
 const Punkt({super.key,this.warning,  required this.onTap, required this.punkt});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 22.5),
      child: GestureDetector(
        onTap: ()=>onTap(context),
        child: Container(
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(233,235,238,1),
                width: 1,
                style: BorderStyle.solid
              )
            )
          ),
          height: 53,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                punkt,
                style:  TextStyle(
                  fontFamily: "SF",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color:warning!=null&&warning==true?Colors.red : Color.fromRGBO(51, 51, 51, 1)
                ),
              ),
              SvgPicture.asset(
                "assets/svg/upToMap.svg",
                // ignore: deprecated_member_use
                color: const Color.fromRGBO(173,179,188,1),
              ),
            ],
          ),
        ),
      ),
    );


  }
}