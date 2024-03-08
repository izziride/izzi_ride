import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/pages/main/tabs/search/result_search/bar_navigation.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({super.key});

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {


  int feedBack=-1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
           BarNavigation(back: true, title: "Feedback"),
           
           Expanded(
             child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Rate the driver.\nHow well was the service provided?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromRGBO(51, 51, 51, 1),
                    fontFamily: "Inter",
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    tappedStar(0),
                    tappedStar(1),
                    tappedStar(2),
                    tappedStar(3),
                    tappedStar(4),               
                  ],
                ),
                SizedBox(height: 100,)
              ],
             ),
           ),
           Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
             child: GestureDetector(
                            onTap: (){
                              
                            },
                            child: Container(
                                  height: 60,
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: brandBlue,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Text(
                                    "feedback",
                                    style: TextStyle(
                                      color: Color.fromRGBO(242, 243, 245, 1),
                                      fontFamily: "Inter",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                          ),
           ),
           SizedBox(height: 20,)
        ],
      ),
    );
  }

Widget tappedStar(int index){
  return GestureDetector(
    onTap: () {
      setState(() {
        feedBack=index;
      });
    },
    child: Icon(Icons.star,size: 60,color: feedBack>=index?Color.fromARGB(255, 240, 217, 11):Color.fromARGB(144, 158, 158, 158),)
  );
}

}