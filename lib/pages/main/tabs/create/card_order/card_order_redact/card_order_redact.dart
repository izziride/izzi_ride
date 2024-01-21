import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:temp/models/preferences/preferences.dart';
import 'package:temp/pages/main/tabs/create/card_order/card_order_redact/models/variables_user_car.dart';
import 'package:temp/pages/main/tabs/create/card_order/dop_options/dop_options.dart';
import 'package:temp/pages/main/tabs/search/result_search/bar_navigation.dart';


class NewDataUserOrder with ChangeNotifier{
  late int _carIdInOrder;
  int get  carIdInOrder=>_carIdInOrder;
  set carIdInOrder(int carIdInOrder_){
    notifyListeners();
    _carIdInOrder=carIdInOrder_;
  }

  late int _seats;
  int get seats=>_seats;
  set seats(int value){
    _seats=value;
  }

  late Preferences _preferences;
   Preferences get  preferences=>_preferences;
  set preferences(Preferences preferences_){
    notifyListeners();
    _preferences=preferences_;
  }
}

 NewDataUserOrder? newDataUserOrder;

class CardOrderReduct extends StatefulWidget {
  final int orderId;
  final int carIdInOrder;
  final Preferences preferences;
  final int seats;
  final Function update;
  const CardOrderReduct({required this.update, required this.orderId, required this.seats, required this.carIdInOrder,required this.preferences, super.key});

  @override
  State<CardOrderReduct> createState() => _CardOrderReductState();
}

class _CardOrderReductState extends State<CardOrderReduct> {

  late int newCarIdInOrder;
  
  void updateNewCarIdInOrder(int carId){
    setState(() {
      print(carId);
    newCarIdInOrder=carId;
    });
  }

  late Preferences newPreferences;

  

  @override
  void initState() {
    newDataUserOrder=NewDataUserOrder()
      .._carIdInOrder=widget.carIdInOrder
      .._preferences=widget.preferences
      ..seats=widget.seats-1;
    inspect(widget.preferences);
    newCarIdInOrder=widget.carIdInOrder;
    newPreferences=widget.preferences;
    super.initState();
  }

  @override
  void dispose() {
    newDataUserOrder=null;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          BarNavigation(back: true, title: "Editing a ride"),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    
                    child: Column(
                      children: [
                        VariableAuto(
                          carIdInOrder:newCarIdInOrder,
                          updateOrderId:updateNewCarIdInOrder
                        ),
                        SizedBox(height: 40,),
                        ReductDopOptions(preferencesWithSeats: PreferencesWithSeats.combine(widget.preferences, widget.seats),carId:widget.carIdInOrder,orderId:widget.orderId,update:widget.update),
                 
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}