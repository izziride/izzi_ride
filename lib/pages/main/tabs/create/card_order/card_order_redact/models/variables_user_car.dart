import 'package:flutter/material.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/http/user/http_user_car.dart';
import 'package:temp/models/car/car.dart';
import 'package:temp/pages/main/tabs/create/card_order/card_order_redact/UI/variable_car.dart';

class VariableAuto extends StatefulWidget {
  final int carIdInOrder;
  final Function updateOrderId;
  const VariableAuto({required this.updateOrderId, required this.carIdInOrder, super.key});

  @override
  State<VariableAuto> createState() => _VariableAutoState();
}

class _VariableAutoState extends State<VariableAuto> {
 late int pressedAutoId;
 late Future _userFuture;
 @override
  void initState() {
    pressedAutoId=widget.carIdInOrder;
    _userFuture=HttpUserCar().getUserCar();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: FutureBuilder(
        future: _userFuture,
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Text("error");
          }
          if(snapshot.connectionState==ConnectionState.waiting){
            return Column(
              children: [
                ShimmerVariableCar(),
                
              ],
            );
          }
          List<UserCar> usercars=snapshot.data!;
          
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for(int i=0;i<usercars.length;i++) 
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      widget.updateOrderId(usercars[i].carId);
                    },
                    child: VariableCar( pressed: widget.carIdInOrder==usercars[i].carId,userCar:usercars[i])
                    ),
                Text(
                  "+ Add car",
                  style: TextStyle(
                    color: brandBlue,
                    fontFamily: "SF",
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
          );
          
        },
        ),
    );
  }
}