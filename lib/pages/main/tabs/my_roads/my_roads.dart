import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/http/orders/orders.dart';
import 'package:temp/pages/main/tabs/emptyState/empty_state.dart';
import 'package:temp/pages/main/tabs/my_roads/components/modal_view.dart';
import 'package:temp/pages/main/tabs/search/UI/search_card/search_card_search.dart';
import 'package:temp/pages/main/tabs/widgets/card_order.dart';
import 'package:temp/repository/user_repo/user_repo.dart';

class MyRoads extends StatefulWidget{
  const MyRoads({super.key});

  @override
  State<MyRoads> createState() => _MyRoadsState();
}

class _MyRoadsState extends State<MyRoads> {

  ScrollController _scrollController =ScrollController();

  int variable=-1;
  bool modalView=false;
  DriverOrder? variableOrder=null;
  Offset offset=Offset(0, 0);
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool auth = userRepository.isAuth;
    return   Stack(
            children: [
              RefreshIndicator(
                  child: SingleChildScrollView(
                    child: Container(
                      color: Color.fromARGB(0, 119, 119, 119),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  onRefresh: ()async{
                    userRepository.getUserBookedOrders();
                  }
                  ),
              Observer(
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
                  return  RefreshIndicator(
                  onRefresh: ()async {
                    
                      userRepository.getUserBookedOrders();
                    
                  },
                  child: Stack(
                    children: [
                       Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: modalView?Color.fromRGBO(109, 106, 106, 1):Colors.white,
                      ),
                      ListView.builder(
                        physics: modalView?NeverScrollableScrollPhysics():BouncingScrollPhysics(),
                        itemCount: myTrips.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onLongPressStart: (details) {
                              setState(() {
                                modalView=true;
                                variable=index;
                               variableOrder=myTrips[index];
                               offset=details.globalPosition;
                              });
                            },
                            child: Stack(
                              children: [
                                CardOrder(
                                  rate: myTrips[index].driverRate,
                                  variable:modalView?variable==index:true,
                                  driverOrder: myTrips[index],
                                  side: (){setState(() {
                                
                                    });}
                                  ,full: false,
                                ),
                              ],
                            ),
                          );
                        },
                        ),
                       
                        modalView==true&&variableOrder!=null?GestureDetector(
                          onTap: () {
                            setState(() {
                              modalView=false;
                              variableOrder=null;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            color: Colors.transparent,
                            ),
                        ):SizedBox.shrink(),
                        modalView==true&&variableOrder!=null? MyRoadActionModal(dy:offset.dy,order:variableOrder!,close:(){
                          setState(() {
                            modalView=false;
                            variableOrder=null;
                          });
                        }):SizedBox.shrink(),

                    ],
                  ),
                );
                    // return   ListView.builder(
                    //           controller: _scrollController,
                    //           itemCount: myTrips.length,
                    //           itemBuilder: (context, index) {
                    //             return CardOrder(side: (){}, driverOrder: myTrips[index],full: false,);
                    //             // GestureDetector(
                    //             //   onLongPressStart: (details) {
                    //             //     openModal(details.globalPosition,myTrips[index]);
                    //             //   },
                    //             //   child: 
                    //             //   ); //CardsearchOrderSearch(driverOrder: trips[index],seats: trips[index].clientReservedSeats!,);
                    //           },
                    //           );
                          
                  },
                
              ),
              
                
            ],
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
    return RefreshIndicator(
      onRefresh: ()async {
        userRepository.isFirstLoadedBooked=false;
        userRepository.getUserBookedOrders();
      },
      child: Center(
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
      ),
    );
  }
}