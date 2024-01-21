import 'package:flutter/material.dart';
import 'package:temp/constants/colors/colors.dart';

class EmptyStateAllPAge extends StatefulWidget {
  const EmptyStateAllPAge({super.key});

  @override
  State<EmptyStateAllPAge> createState() => _EmptyStateAllPAgeState();
}

class _EmptyStateAllPAgeState extends State<EmptyStateAllPAge> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 110.8,),
        Image.asset("assets/image/empty_state_all.png"),
        SizedBox(height: 32,),
        Text(
          "Sign in to continue.",
          style: TextStyle(
            fontFamily: "SF",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: brandBlack
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "Authorization will allow you to start communicating with fellow travelers to save money on travel together and make travel even more convenient.",
            style: TextStyle(
              
              fontFamily: "SF",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: brandBlack
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 32,),
        InkWell(
          onTap: () {
             Navigator.pushNamedAndRemoveUntil(context,"/reg",(route)=>false);
          },
          child: Container(
            height: 60,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color.fromRGBO(64, 123, 255, 1),
              borderRadius: BorderRadius.circular(12)
            ),
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Sign in",
              style: TextStyle(
              fontFamily: "SF",
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white
            ),
            ),
          ),
        )
      ],
    );
  }
}