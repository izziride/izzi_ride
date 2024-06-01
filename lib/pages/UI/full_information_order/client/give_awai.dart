import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class FO_GiveWay extends StatefulWidget {
  final String code;
  const FO_GiveWay({super.key,required this.code});

  @override
  State<FO_GiveWay> createState() => _FO_GiveWayState();
}

class _FO_GiveWayState extends State<FO_GiveWay> {

  double opacity=0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
          margin: EdgeInsets.all(20),
          width: double.infinity,
          height: 80,
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 5,),
              Text(
                  "Gift code!!!",
                  style: TextStyle(
                    color: Color.fromARGB(255, 143, 27, 211),
                    fontFamily: "Inter",
                    fontSize: 25,
                    fontWeight: FontWeight.w600
                  ),
                ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                                widget.code,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Inter",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                              SizedBox(width: 20,),
                              GestureDetector(
                                onTap: () async{
                                  await Clipboard.setData(ClipboardData(text: widget.code));
                                  setState(() {
                                    opacity=0.8;
                                  });
                                  await Future.delayed(Duration(milliseconds: 600));
                                  setState(() {
                                    opacity=0;
                                  });
                                },
                                child: Container(
                                  height: 30,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.copy,size: 20,),
                                      Text(
                                      "copy",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Inter",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400
                                      ),
                                    ),
                                    ],
                                  ),
                                ),
                              ),
                              
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Center(
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 600),
              opacity: opacity,
              child: Container(
                width: 150,
                height: 30,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 204, 201, 201),
                  borderRadius: BorderRadius.circular(5)
                ),
                alignment: Alignment.center,
                child: Text(
                          "coped!!!",
                          style: TextStyle(
                            color: Color.fromARGB(255, 54, 54, 54),
                            fontFamily: "Inter",
                            fontSize: 18,
                            fontWeight: FontWeight.w400
                          ),
                        ),
              ),
            ),
          )
        )
      ],
    );
  }
}