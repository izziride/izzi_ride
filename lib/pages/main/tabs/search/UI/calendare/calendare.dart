
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/pages/main/tabs/search/UI/calendare/modal_calendare.dart';

class Calendare extends StatefulWidget{
  final DateTime date;
  final Function updateDate;
  const Calendare({required this.updateDate, required this.date, super.key});
  @override
  State<Calendare> createState() => _CalendareState();
}

class _CalendareState extends State<Calendare> {

  

  void _showDialogPage(BuildContext context){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context){
        return CalendarModal(update:widget.updateDate,date:widget.date);
      },
      );
      
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        _showDialogPage(context);
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color:categorySelected,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18,right: 11),
              child: SvgPicture.asset(
                      "assets/svg/calendare.svg"
                      ),
            ),
            Text(
              widget.date.day==DateTime.now().day?"Today":DateFormat("dd MMMM yyyy").format(widget.date),
              style: TextStyle(
                fontFamily: "SF",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: brandBlack
              ),
              )
          ],
        ),
      ),
    );
  }
}