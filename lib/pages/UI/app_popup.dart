import 'package:flutter/material.dart';

class AppPopup extends StatelessWidget {
  final String title;
  final String description;
  final Function pressYes;
  final Function pressNo;
  final bool warning;
  const AppPopup({
    required this.warning,
    required this.title,
    required this.description,
    required this.pressYes,
    required this.pressNo,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: Color.fromRGBO(242, 242, 242, 0.8)
    ),
    height: 138,
    width: 270,
      child: Column(
        children: [
          SizedBox(height: 19,),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                      fontFamily: "SF",
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      color:warning?Colors.red: Colors.black,
                      
                    ),
                    
          ),
          SizedBox(height: 2,),
           Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
                      fontFamily: "SF",
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Colors.black,
                      
                    ),
                    
                    
          ),
          SizedBox(height: 19,),
          Container(
            height: 44,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color.fromRGBO(60, 60, 67, 0.36),
                  width: 0.5,
                  style: BorderStyle.solid
                )
              )
            ),
            child: Row(
              children: [
                InkWell(
                  
                  onTap: () => pressNo(),
                  
                    child: SizedBox(
                      width: 270/2-0.25,
                      child: Text(
                        "No",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                        fontFamily: "SF",
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                        color: Color.fromRGBO(0, 122, 255, 1),
                        
                      ),
                        ),
                    ),
                  
                ),
               
                 Container(
                              
                    width: 0.5,
                  
                    color: Color.fromRGBO(60, 60, 67, 0.36),
                  ),
               
                InkWell(
                  onTap: ()=>pressYes(),
                  child: SizedBox(
                      width: 270/2-0.25,
                      child: Text(
                        "Yes",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                        fontFamily: "SF",
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        color:warning?Colors.red: Color.fromRGBO(0, 122, 255, 1),
                        
                      ),
                      ),
                    ),
                  
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}