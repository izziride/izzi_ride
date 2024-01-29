import 'package:flutter/material.dart';
import 'package:temp/constants/colors/colors.dart';

class MessagesEmptyState extends StatelessWidget{
  const MessagesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/image/3.png"),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              "Your future chats will appear here!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "SF",
                color: brandBlack,
                fontSize: 20,
                fontWeight: FontWeight.w700
              ),
            ),
          ),
        ),
         Container(
          alignment: Alignment.center,
          child: Text(
            "On this page you will find a list of your future chats with your ridemates.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "SF",
              color: brandBlack,
              fontSize: 16,
              fontWeight: FontWeight.w400
            ),
          ),
        )
      ],
    );
  }

}