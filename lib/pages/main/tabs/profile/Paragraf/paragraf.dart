import 'package:flutter/material.dart';

class ParagrafModel{
  String paragraf="";
  
  List<String>list=[];
  ParagrafModel(this.paragraf, this.list,);
}

class Paragraf extends StatelessWidget   {
 final  Function? onTap;
 final String paragraf;
 const Paragraf({super.key, required this.paragraf,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: 30,left: 15,bottom: paragraf=="Exit"?30:8),
      child: InkWell(
        onTap: () {
          if(onTap!=null){
            onTap!(context);
          }
        },
        child: Text(
          paragraf,
          style: TextStyle(
            fontFamily: "SF",
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: paragraf=="Exit"?const Color.fromRGBO(58,121,215,1):const Color.fromRGBO(51,51,51,1)
          ),
        ),
      ),
    );


  }
}