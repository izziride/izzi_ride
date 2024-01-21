import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/pages/main/tabs/create/search_city_create/search_city_create.dart';



class CardCoordinates extends StatefulWidget{
 final SvgPicture icon;
 final String hint;
 final Function(String,String,double,double)  update;
 final String name;
 final bool valid;
 const CardCoordinates({required this.valid, required this.name, required this.update, required this.icon,required this.hint, super.key});

  @override
  State<CardCoordinates> createState() => _CardCoordinatesState();
}

class _CardCoordinatesState extends State<CardCoordinates> {



void _showAnimation(BuildContext context) {
  ArgumentSetting params = ArgumentSetting(widget.icon,widget.hint);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SearchFrom(update: widget.update,city:widget.name),
      
      settings: RouteSettings(arguments:params), 
    ),
  );
}





  @override
  Widget build(BuildContext context) {



   return GestureDetector(
      onTapDown: (details) {
        _showAnimation(context);
  },
     child: Container(
              height: 60,
              decoration: BoxDecoration(
                border:widget.valid?null: Border.all(
                  color:  Colors.red,
                  width: 1,
                  style: BorderStyle.solid
                ),
                color: categorySelected,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16,right: 9),
                    child: widget.icon
                  ),
                   Text(widget.name.isNotEmpty?widget.name:widget.hint)
                ],
              ),
             ),
   );
  }
}

