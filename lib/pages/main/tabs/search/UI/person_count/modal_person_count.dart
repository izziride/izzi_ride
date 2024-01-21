import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

TextStyle localTextStyle = const TextStyle(
  color: Color.fromRGBO(58,121,215,1),
  fontFamily: "Inter",
  fontSize: 16,
  fontWeight: FontWeight.w500
);


class ModalPersonCount extends StatefulWidget {
 final int count;
 final Function setter;
 const  ModalPersonCount({required this.setter, required this.count,super.key});


  @override
  State<ModalPersonCount> createState() => _ModalPersonCount();
}
DateTime date=DateTime.now();


class _ModalPersonCount extends State<ModalPersonCount> {


int count=1;
void _increment(){
  if(count<4){
    setState(() {
    count++;
  });
  }
  
}
void _decrement(){
   if(count>1){
    setState(() {
    count--;
  });
  }
}

@override
  void initState() {
    count=widget.count;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        InkWell(
            onTap: (){
              
              Navigator.pop(context);
            },
            child: Container(
              height: 90,
              color: Colors.transparent,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 12,left: 15,right: 15),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                       Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: localTextStyle,
                            ),
                        ),
                        InkWell(
                          onTap: (){
                              widget.setter(count);
                              Navigator.pop(context);
                          },
                          child: Text(
                            "Confirm",
                            style: localTextStyle,
                            ),
                        )
                      ],
                  ),
                   Padding(
                    padding: EdgeInsets.only(top: 20,bottom: 20),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Number of reserved seats",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "SF",
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(51,51,51,1)
                        ),
                        ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              _decrement();
                            },
                            child: SvgPicture.asset(
                              "assets/svg/personMinus.svg",
                                // ignore: deprecated_member_use
                                color:count>1?const Color.fromRGBO(58,121,215,1):const Color.fromRGBO(177,177,177,1),
                            ),
                          ),
                          Text(
                            count.toString(),
                            style: const TextStyle(
                              fontFamily: "SF",
                              fontSize: 56,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(51,51,51,1)
                            )
                            ),
                           InkWell(
                            onTap: (){
                              _increment();
                            },
                             child: SvgPicture.asset(
                              "assets/svg/personPlus.svg",
                                // ignore: deprecated_member_use
                                color:count<4?const Color.fromRGBO(58,121,215,1):const Color.fromRGBO(177,177,177,1),
                                                 ),
                           )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
      ],
    );
  }
}