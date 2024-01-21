
import 'package:flutter/material.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/pages/main/tabs/create/enumMap/enum_map.dart';
import 'package:temp/pages/main/tabs/create/modal/name_modal.dart';





class CardCar extends StatefulWidget{
  final bool valid;
 final MyEnum types;
 final Function(String,int) update;
 final String title;
  final String other;
  final int id;
  const CardCar({required this.valid,required this.id, required this.other, required this.title, required this.update, required this.types, super.key});

  @override
  State<CardCar> createState() => _CardCarState();
}

class _CardCarState extends State<CardCar> {


  String currentValue="";
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap:(){
          if(widget.other.isNotEmpty){
            showBottomSheet(
          context: context,
           builder:(context)=>NameModal(types: widget.types,update:widget.update,id: widget.id,)
           );
          }
         
        },
        child: Container(
          alignment: Alignment.centerLeft,
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromRGBO(237, 238, 243, 1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: widget.valid?Color.fromRGBO(237, 238, 243, 1):Colors.red
            )
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              widget.title.isNotEmpty?widget.title:"Specify ${typeWindow[widget.types]}",
              style:  TextStyle(
                fontFamily: "SF",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: brandBlack
              ),
            ),
          ),
        ),
      ),
    );
  }
}