import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel, WeekdayFormat;
import 'package:temp/constants/colors/colors.dart';


class CalendarModal extends StatefulWidget {
  final Function update;
  final DateTime date;
  const CalendarModal({required this.date, required this.update, super.key});

  @override
  State<CalendarModal> createState() => _CalendarModalState();
}

class _CalendarModalState extends State<CalendarModal> {
late String _currentMonth;
late DateTime _selectedDate;

@override
  void initState() {
    _currentMonth=DateFormat("MMMM y").format(widget.date);
    _selectedDate=widget.date;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {



final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.transparent,
      minSelectedDate: DateTime.now().subtract(Duration(days: 1)),
      onDayPressed: (date, events) {
        if(date.isBefore(DateTime.now())){
          print(date.microsecondsSinceEpoch);
          print(DateTime.now().microsecondsSinceEpoch);
          setState(() {
            _selectedDate=DateTime.now();
          });
          return;
        }
        final d=date.toUtc().millisecondsSinceEpoch ~/ 1000;
        print(d);
         setState(() {
          _selectedDate = date;
          _currentMonth = DateFormat("MMMM y").format(date);
        });
      },
      weekDayMargin: EdgeInsets.zero,
      daysHaveCircularBorder: false,
      customDayBuilder: (isSelectable, index, isSelectedDay, isToday, isPrevMonthDay, textStyle, isNextMonthDay, isThisMonthDay, day) {
        return InkWell(
          splashColor: Colors.amber,
          highlightColor: Colors.transparent,
          child: Ink(
            height: 44,
            width: 44,
            child: Container(
              height: 24,
              width: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:isSelectedDay? brandBlue:Colors.transparent,
                borderRadius: BorderRadius.circular(4)
              ),
              child: Text(
                day.day.toString(),
                style: TextStyle(
                  color: isSelectedDay?Colors.white: brandBlack,
                  fontFamily: "SF",
                  fontWeight: FontWeight.w400,
                  fontSize: 20
                ),
                ),
            ),
          ),
        );
      },
      showOnlyCurrentMonthDate: true,
      selectedDateTime: _selectedDate,
      weekdayTextStyle: TextStyle(
        color: Color.fromRGBO(60, 60, 67, 0.3),
        fontFamily: "SF",
        fontWeight: FontWeight.w600,
        fontSize: 13
      ),
      weekendTextStyle: TextStyle(
        color: brandBlack,
      ),
      weekDayFormat:WeekdayFormat.short,
      thisMonthDayBorderColor: Colors.transparent,
      weekFormat: false,
      height: 380,
//      firstDayOfWeek: 4,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      onCalendarChanged: (DateTime date) {
        
        if(date.month!=_selectedDate.month){
          print(false);
            setState(() {
          _selectedDate = DateTime.now();
          _currentMonth = DateFormat("MMMM y").format(date);
        });
        }
        
      },
      showHeader: false,
      todayTextStyle: TextStyle(
        color: brandBlack
      ),
      
      // markedDateShowIcon: true,
      // markedDateIconMaxShown: 2,
      // markedDateIconBuilder: (event) {
      //   return event.icon;
      // },
      // markedDateMoreShowTotal:
      //     true,
      todayButtonColor: Colors.transparent,
      selectedDayTextStyle: TextStyle(
        color: Colors.white,
      ),
      targetDateTime: _selectedDate,
      selectedDayButtonColor: Colors.transparent,
      selectedDayBorderColor: Colors.transparent,
      dayPadding: 4,
      
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.transparent,

      ),
      nextDaysTextStyle: TextStyle(
        color: Colors.amber
      ),
      inactiveDaysTextStyle: TextStyle(
        color: brandBlue,
        fontSize: 16,
      ),
    );




    return  Column(
        
        children: [
          InkWell(
            onTap: (){
              
              Navigator.pop(context);
            },
            child: Container(
              height: 100,
              color: Colors.transparent,
            ),
          ),
          Expanded(
            child: Container(
              color: Color.fromRGBO(245,245,245,1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                      Padding(
                        padding: const EdgeInsets.only(top:12,bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel",
                              style:TextStyle(
                                fontFamily: "Inter",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: brandBlue
                              ) ,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                widget.update(_selectedDate);
                                Navigator.pop(context);
                              },
                              child: Text("Save",
                                style:TextStyle(
                                fontFamily: "Inter",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: brandBlue
                              ) 
                              ),
                            )
                          ],
                        ),
                        
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom:20),
                        child: Text(
                          "Select travel date",
                          style: TextStyle(
                            color: brandBlack,
                            fontFamily: "SF",
                            fontSize: 24,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                       Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(13),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                                spreadRadius: 0,
                                blurRadius: 60,
                                offset: Offset(0, 10), 
                              ),
                            ]
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:11,bottom: 11,right: 14,top: 17),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _currentMonth,
                                      style: TextStyle(
                                        color: brandBlack,
                                        fontFamily: 'SF',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600                                    ),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              _selectedDate = DateTime(
                                                  _selectedDate.year, _selectedDate.month - 1);
                                              _currentMonth =
                                                  DateFormat.yMMM().format(_selectedDate);
                                            });
                                          },
                                          child: SvgPicture.asset("assets/svg/back.svg",width: 10,height: 17,)),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 31),
                                          child: InkWell(
                                             onTap: () {
                                            setState(() {
                                              _selectedDate = DateTime(
                                                  _selectedDate.year, _selectedDate.month + 1);
                                              _currentMonth =
                                                  DateFormat.yMMM().format(_selectedDate);
                                            });
                                          },
                                            child: Transform.rotate(
                                              angle: 3.1415926535,
                                              child: SvgPicture.asset("assets/svg/back.svg",width: 10,height: 17,)),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              _calendarCarouselNoHeader
                            ],
                          )
                          
                          
                       ),
                  ],
                ),
              ),
            ),
          ),
        ],
          
     
        );
  }
}