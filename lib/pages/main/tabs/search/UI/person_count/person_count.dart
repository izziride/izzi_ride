
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/pages/main/tabs/search/UI/person_count/modal_person_count.dart';

class PersonCount extends StatefulWidget{
  final int count;
  final Function update;
  const PersonCount({required this.count,required this.update, super.key});
  @override
  State<PersonCount> createState() => _PersonCountState();
}

class _PersonCountState extends State<PersonCount> {



@override
  void initState() {
    super.initState();
  }





 void _showDialogPage(BuildContext context){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context){
        return ModalPersonCount(count:widget.count,setter:widget.update);
      },
      );
      
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: (){
            _showDialogPage(context);
        },
        child: Container(
           height: 60,
            decoration: BoxDecoration(
              color:categorySelected,
              borderRadius: BorderRadius.circular(10),
          
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 19,right: 12),
                child: SvgPicture.asset(
                  "assets/svg/person.svg"
                ),
              ),
              Text(widget.count.toString())
            ]
            ),
        ),
      ),
    );
  }
}