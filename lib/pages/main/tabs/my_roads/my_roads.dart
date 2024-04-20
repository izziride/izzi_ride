import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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

  double height=0;
  bool contextMenu=false;
  List<int> variableOrderId=[];
  @override
  Widget build(BuildContext context) {
    if(variableOrderId.isEmpty){
      setState(() {
        height=0;
        contextMenu=false;
      });
    }
     bool auth = userRepository.isAuth;
    if(!auth){
      return const EmptyStateAllPAge();
    }
    return Column(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: height,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: brandBlue,
                width: 2
              )
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                        setState(() {
                          variableOrderId=[];
                          height=0;
                          contextMenu=false;
                        });
                      },
                child: Row(
                  children: [
                    SizedBox(width: 20,),
                    Icon(Icons.close, size: height.clamp(0, 30),color: brandBlue,)
                  ],
                ),
              ),
                GestureDetector(
                  onTap: ()async {
                    List<DriverOrder> orders = userRepository.userBookedOrders;
                    for(DriverOrder order in orders){
                      if(variableOrderId.contains(order.orderId) && (order.bookedStatus=="unbooked" || order.status=="finished")){
                        int result=await HttpUserOrder().hideOrderBooking(order.orderId);
                        if(result==0){
                          userRepository.deleteUserBookedOrders(order.orderId);
                        }
                      }
                    }
                    setState(() {
                      variableOrderId=[];
                      contextMenu=false;
                      height=0;
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                          "${variableOrderId.length>0?variableOrderId.length.toString():""}",
                          style: TextStyle(
                            color: brandBlue,
                            fontFamily: "SF",
                            fontSize: 20
                            
                          ),
                        ),
                      Icon(Icons.delete_forever_outlined, size: height.clamp(0, 30),color: brandBlue,),
                        
                          SizedBox(width: 20,),
                    ],
                  ),
                )
            ],
          ),
        ),
        Expanded(
          child: Observer(
            builder: (context) {
              if(!userRepository.isFirstLoadedBooked && userRepository.userBookedOrders.isEmpty){
                userRepository.getUserBookedOrders();
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<DriverOrder> orders = userRepository.userBookedOrders;
              if(orders.length==0){
                return emptyState();
              }
              print("object");
              return RefreshIndicator(
                        onRefresh: ()async {
                          setState(() {
                            userRepository.isFirstLoadedBooked=false;
                            userRepository.getUserBookedOrders();
                          });
                        },
                        child: ListView.builder(
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                if(contextMenu){
                                  bool find=false;
                                  for(int orderId in variableOrderId){
                                    if(orderId==orders[index].orderId){
                                      find=true;
                                      break;
                                    }
                                  }
                                  if(find){
                                    variableOrderId=variableOrderId.where((element) => element!=orders[index].orderId).toList();
                                  }else{
                                    variableOrderId.add(orders[index].orderId);
                                  }
                                  setState(() {
                                    
                                  });
                                }
                              },
                              onLongPress: () {
                                setState(() {
                                  height=70;
                                  contextMenu=true;
                                  variableOrderId.add(orders[index].orderId);
                                });
                              },
                              child: Builder(
                                builder: (context) {
                                  bool variable=false;
                                  for(int orderId in variableOrderId){
                                    if(orderId==orders[index].orderId){
                                      variable=true;
                                      break;
                                    }
                                  }
                                  return CardOrder(rate:orders[index].driverRate , variable: variable, driverOrder: orders[index],side: (){setState(() {
                                    
                                  });},full: false,);
                                }
                              ),
                            );
                          },
                          ),
                      );
            },
            ),
        ),
      ],
    );
  }
    // return   Stack(
    //         children: [
    //           RefreshIndicator(
    //               child: SingleChildScrollView(
    //                 child: Container(
    //                   color: Color.fromARGB(0, 119, 119, 119),
    //                   height: MediaQuery.of(context).size.height,
    //                   width: MediaQuery.of(context).size.width,
    //                 ),
    //               ),
    //               onRefresh: ()async{
    //                 userRepository.getUserBookedOrders();
    //               }
    //               ),
    //           Observer(
    //               builder: (context) {
    //                 if(!userRepository.isAuth){
    //                   return EmptyStateAllPAge();
    //                 }    
    //                 if(!userRepository.isFirstLoadedBooked && userRepository.userBookedOrders.isEmpty){
    //                   userRepository.getUserBookedOrders();
    //                   return Center(
    //                     child: CircularProgressIndicator(),
    //                   );
    //                 }
    //                 List<DriverOrder> myTrips = userRepository.userBookedOrders;
    //                 if(myTrips.length==0){
    //                   return emptyState();
    //                 }
    //               return  RefreshIndicator(
    //               onRefresh: ()async {
                    
    //                   userRepository.getUserBookedOrders();
                    
    //               },
    //               child: Stack(
    //                 children: [
    //                    Container(
    //                     width: MediaQuery.of(context).size.width,
    //                     height: MediaQuery.of(context).size.height,
    //                     color: modalView?Color.fromRGBO(109, 106, 106, 1):Colors.white,
    //                   ),
    //                   ListView.builder(
    //                     physics: modalView?NeverScrollableScrollPhysics():BouncingScrollPhysics(),
    //                     itemCount: myTrips.length,
    //                     itemBuilder: (context, index) {
    //                       return GestureDetector(
    //                         onLongPressStart: (details) {
    //                           setState(() {
    //                             modalView=true;
    //                             variable=index;
    //                            variableOrder=myTrips[index];
    //                            offset=details.globalPosition;
    //                           });
    //                         },
    //                         child: Stack(
    //                           children: [
    //                             CardOrder(
    //                               rate: myTrips[index].driverRate,
    //                               variable:modalView?variable==index:true,
    //                               driverOrder: myTrips[index],
    //                               side: (){setState(() {
                                
    //                                 });}
    //                               ,full: false,
    //                             ),
    //                           ],
    //                         ),
    //                       );
    //                     },
    //                     ),
                       
    //                     modalView==true&&variableOrder!=null?GestureDetector(
    //                       onTap: () {
    //                         setState(() {
    //                           modalView=false;
    //                           variableOrder=null;
    //                         });
    //                       },
    //                       child: Container(
    //                         width: MediaQuery.of(context).size.width,
    //                         height: MediaQuery.of(context).size.height,
    //                         color: Colors.transparent,
    //                         ),
    //                     ):SizedBox.shrink(),
    //                     modalView==true&&variableOrder!=null? MyRoadActionModal(dy:offset.dy,order:variableOrder!,close:(){
    //                       setState(() {
    //                         modalView=false;
    //                         variableOrder=null;
    //                       });
    //                     }):SizedBox.shrink(),

    //                 ],
    //               ),
    //             );
    //                 // return   ListView.builder(
    //                 //           controller: _scrollController,
    //                 //           itemCount: myTrips.length,
    //                 //           itemBuilder: (context, index) {
    //                 //             return CardOrder(side: (){}, driverOrder: myTrips[index],full: false,);
    //                 //             // GestureDetector(
    //                 //             //   onLongPressStart: (details) {
    //                 //             //     openModal(details.globalPosition,myTrips[index]);
    //                 //             //   },
    //                 //             //   child: 
    //                 //             //   ); //CardsearchOrderSearch(driverOrder: trips[index],seats: trips[index].clientReservedSeats!,);
    //                 //           },
    //                 //           );
                          
    //               },
                
    //           ),
              
                
    //         ],
    //       );

  

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
      child:  SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height-70,
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
                            "On this page you will find rides you've already booked.",
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
              ),
              
            ],
          ),
        ),
      
        
    );
  }
}