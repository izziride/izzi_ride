import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class TimePickerModal extends StatefulWidget {
  final Function update;
  const TimePickerModal({required this.update, super.key});

  @override
  State<TimePickerModal> createState() => _TimePickerModal();
}
DateTime date=DateTime.now();
class _TimePickerModal extends State<TimePickerModal> {


  @override
  Widget build(BuildContext context) {
    return  Column(
        
        children: [
          InkWell(
            onTap: (){
              
              Navigator.pop(context);
            },
            child: Container(
              height: MediaQuery.of(context).size.height*0.6,
              color: Colors.transparent,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CupertinoTheme(
                      
                        data:CupertinoThemeData(

                          applyThemeToAll: false,
                          textTheme:CupertinoTextThemeData(
                            
                            dateTimePickerTextStyle: TextStyle(
                            color: Theme.of(context).brightness==Brightness.dark?Colors.black:Colors.black,
                            wordSpacing: 40,
                            fontSize: 26
                          )
                          ) 
                        ), 
                        
                        child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            initialDateTime: DateTime(0),
                            minuteInterval: 15,
                            
                            onDateTimeChanged: (DateTime newDateTime) {
                               widget.update(newDateTime);
                            },
                          ),
                      ),
                    ),
                      //  TimePickerSpinner(
                      //   is24HourMode: true,
                      //     normalTextStyle: TextStyle(fontSize: 24),
                      //     highlightedTextStyle: TextStyle(fontSize: 30, color: Colors.blue),
                      //     spacing: 30,
                      //     minutesInterval: ,
                      //     isForce2Digits: true,
                      //     itemHeight: 80,
                      //     onTimeChange: (time) {
                      //       widget.update(time);
                      //     },
                      //  )
                  ],
                ),
              ),
            ),
          ),
        ],
          
     
        );
  }
}