import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/http/orders/orders.dart';
import 'package:temp/pages/main/tabs/emptyState/empty_state.dart';
import 'package:temp/pages/main/tabs/search/UI/search_card/search_card_search.dart';
import 'package:temp/repository/user_repo/user_repo.dart';

class MyRoads extends StatefulWidget{
  const MyRoads({super.key});

  @override
  State<MyRoads> createState() => _MyRoadsState();
}

class _MyRoadsState extends State<MyRoads> {
  @override
  Widget build(BuildContext context) {
    bool auth = userRepository.isAuth;
    return auth?  FutureBuilder<List<DriverOrderFind>>(
      future: HttpUserOrder().myTrips(),
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return errorState();
        }
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<DriverOrderFind> trips=snapshot.data!;
        print(trips.length);
        if(trips.length==0){
          return emptyState();
        }
        return RefreshIndicator(
          
          onRefresh: ()async {
            setState(() {
              
            });
          },
          child: ListView.builder(
            itemCount: trips.length,
            itemBuilder: (context, index) {
              return CardsearchOrderSearch(driverOrder: trips[index],seats: trips[index].clientReservedSeats!,);
            },
            ),
        );
      },
    )
    : EmptyStateAllPAge()
    ;
  }

  Widget errorState(){
    return Center(
      child: Text(
        "error"
      ),
    );
  }

  Widget emptyState(){
    return Center(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/image/my_trips.png"),
            Padding(
              padding: const EdgeInsets.only(top:32,bottom: 12),
              child: Text(
                "Your booked ride will appear here!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: brandBlack,
                  fontFamily: "SF",
                  fontSize: 20,
                  fontWeight: FontWeight.w700
                ),
                ),
            ),
              Text(
              "On this page you will find rides you already booked.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: brandBlack,
                fontFamily: "SF",
                fontSize: 16,
                fontWeight: FontWeight.w400
              ),
              )
          ],
        ),
      )
    );
  }
}