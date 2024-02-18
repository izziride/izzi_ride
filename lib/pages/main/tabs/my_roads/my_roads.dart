import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/http/orders/orders.dart';
import 'package:temp/pages/main/tabs/emptyState/empty_state.dart';
import 'package:temp/pages/main/tabs/search/UI/search_card/search_card_search.dart';
import 'package:temp/pages/main/tabs/widgets/card_order.dart';
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
    return Observer(
      builder: (context) {
        if(!userRepository.isAuth){
          return EmptyStateAllPAge();
        }    
        if(!userRepository.isFirstLoadedBooked && userRepository.userBookedOrders.isEmpty){
          userRepository.getUserBookedOrders();
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<DriverOrder> myTrips = userRepository.userBookedOrders;
        if(myTrips.length==0){
          return emptyState();
        }

        return RefreshIndicator(
          
          onRefresh: ()async {
            userRepository.isFirstLoadedBooked=false;
            userRepository.getUserBookedOrders();
          },
          child: ListView.builder(
            itemCount: myTrips.length,
            itemBuilder: (context, index) {
              return CardOrder(side: (){}, driverOrder: myTrips[index],full: false,); //CardsearchOrderSearch(driverOrder: trips[index],seats: trips[index].clientReservedSeats!,);
            },
            ),
        ); 
      },
    );
    
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