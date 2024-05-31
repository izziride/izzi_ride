
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:temp/http/orders/orders.dart';
import 'package:temp/pages/main/tabs/search/UI/search_card/search_card_search.dart';
import 'package:temp/pages/main/tabs/search/result_search/bar_navigation.dart';
import 'package:temp/pages/main/tabs/widgets/card_order.dart';
import 'package:temp/repository/search_repo/search_repo.dart';

class ResultSearch extends StatefulWidget{

 const ResultSearch({super.key});

  @override
  State<ResultSearch> createState() => _ResultSearchState();
}

class _ResultSearchState extends State<ResultSearch> {



  DateFormat dateFormat = DateFormat('d MMMM');
  DateTime date=DateTime.now(); 
  Widget other=SizedBox.shrink();
  int currentIndex=0;
  late Future<List<String>> _futureSimilar;
  List<String> similarOrder=[];

  List<Widget> listOrder=[];
  List<Widget> listotherOrder=[];
  String dateConverter(String date){
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ssZ');
    String formattedTime = formatter.format(DateTime.parse(date));
    String tzName(Duration offset) {
      String hours = offset.inHours.abs().toString().padLeft(2, '0');
      String minutes = (offset.inMinutes % 60).abs().toString().padLeft(2, '0');
      String sign = offset.isNegative ? '-' : '+';

      return '$sign$hours:$minutes';
    }
    formattedTime += tzName(DateTime.parse(date).timeZoneOffset);

    return formattedTime;
   }
  void getOtherOrder(String date)async{
  listotherOrder=[];
    List<DriverOrderFind> otherOrder = await  HttpUserOrder().findUserOrderByOtherCity(
                     searchRepo.fromCityId,
                     searchRepo.toCityId,
                     searchRepo.personCount,
                     dateConverter(date)
                    );
                    print(otherOrder.length);
                    
                    if(otherOrder.length>0){
                      setState(() {
                        listotherOrder.add(Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text("Ride on other cities",textAlign: TextAlign.center,style: TextStyle(
                            fontSize: 20,
                            fontFamily: "SF"
                          ),),
                        ));
                        listotherOrder.add(Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 31),
                          child: Image.asset("assets/image/otherCity1.png",),
                        ));
                        for(int i=0;i<otherOrder.length;i++){
                          final driverOrder= DriverOrder(driverRate: otherOrder[i].driverRate, bookedStatus: otherOrder[i].bookedStatus, status: "", userId: otherOrder[i].driverId, orderId: otherOrder[i].orderId, clientAutoId: otherOrder[i].driverId, departureTime: otherOrder[i].departureTime, nickname: otherOrder[i].nickname, orderStatus: "", startCountryName: otherOrder[i].startPoint.city, endCountryName: otherOrder[i].endPoint.city, seatsInfo: otherOrder[i].seatsInfo, price: otherOrder[i].price, preferences: otherOrder[i].preferences);
                          listotherOrder.add(
                            CardOrder(rate: otherOrder[i].driverRate, variable: false, side: (){}, driverOrder: driverOrder, full: false)
                            //CardsearchOrderSearch(driverOrder: otherOrder[i],seats:searchRepo.personCount)
                          );
                        }
                       
                       
                      });
                    }else{
                      setState(() {
                        listotherOrder=[];
                      });
                    }
  }

  void getOrder(String date)async{
    listOrder=[];
        List<DriverOrderFind> otherOrder = await  HttpUserOrder().findUserOrder(
                     searchRepo.fromCityId,
                     searchRepo.toCityId,
                     searchRepo.personCount,
                     dateConverter(date)
                    );
                    if(otherOrder.length>0){
                      setState(() {
                        for(int i=0;i<otherOrder.length;i++){
                          final driverOrder= DriverOrder(driverRate: otherOrder[i].driverRate, bookedStatus: otherOrder[i].bookedStatus, status: "", userId: otherOrder[i].driverId, orderId: otherOrder[i].orderId, clientAutoId: otherOrder[i].driverId, departureTime: otherOrder[i].departureTime, nickname: otherOrder[i].nickname, orderStatus: "", startCountryName: otherOrder[i].startPoint.city, endCountryName: otherOrder[i].endPoint.city, seatsInfo: otherOrder[i].seatsInfo, price: otherOrder[i].price, preferences: otherOrder[i].preferences);
                          
                        // listOrder= listOrder.sublist(1,listOrder.length);
                          listOrder.insert(0,
                          CardOrder(rate: otherOrder[i].driverRate, variable: false, side: (){}, driverOrder: driverOrder, full: false)
                           // CardsearchOrderSearch(driverOrder: otherOrder[i],seats:searchRepo.personCount)
                          );
                        }
                       //listOrder.insert(0,otherOrder);
                       
                      });
                    }else{
                      setState(() {
                        listOrder.insert(0, Column(
                          children: [
                            Image.asset("assets/image/emptyOrder.png"),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: Text(
                                    "Unfortunately, the travel companion\nwas not found at this date.\nPlease choose another date\nfrom those suggested above or try later.",
                                    textAlign: TextAlign.center,
                                ),
                            ),
                          ],
                        ));
                       
                      });
                    }
  }

  @override
  void initState() {
     
   print(searchRepo.date);
    date=searchRepo.date;
    similarOrder.add(date.toString());
      getOrder(searchRepo.date.toString());
     getOtherOrder(searchRepo.date.toString());
    _futureSimilar=HttpUserOrder().findUserSimilarOrder(
                               searchRepo.fromCityId,
                                searchRepo.toCityId,
                                searchRepo.personCount,
                                dateConverter(searchRepo.date.toString())
                                
                            );
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fullList=listOrder+listotherOrder;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            toolbarHeight: 0,
            backgroundColor: Colors.white,
            toolbarOpacity: 0,
            elevation: 0,
            
        ),
      body: Column(
        children: [
          BarNavigation(back: true, title: "${searchRepo.fromCity} - ${searchRepo.toCity}"),
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8,bottom: 10),
                        child: Text(
                          "Transportation on other days",
                          style: TextStyle(
                            fontFamily: "SF",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(51, 51, 51, 1)
                          ),
                        ),
                      ),
                      SizedBox(
                          height: 32,
                          width: double.infinity,
                          child: FutureBuilder<List<String>>(
                            future: _futureSimilar,
                            builder: (context, snapshot) {
                              if(snapshot.connectionState==ConnectionState.waiting){
                                return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context,index){
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                      alignment: Alignment.center,
                                      width: 91,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100]!,
                                        borderRadius: BorderRadius.circular(32),
                                        border: Border.all(color: const Color.fromRGBO(64, 123, 255, 1)),
                                      ),
                                    ),
                                ),
                              );
                            }
                            );
                              }
                              if(snapshot.hasError){
                                return Center(
                                  child: Text("error")
                                );
                              }
                              List<String> similar=[searchRepo.date.toString()];
                              similar.addAll(snapshot.data!);
                             
                              
                              return ListView.builder(
                                itemCount: similar.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(32),
                                  onTap: () {
                                    if(currentIndex!=index){
                                      setState(() {
                                        date=DateTime.parse(similar[index]);
                                        currentIndex=index;
                                        getOrder(date.toString());
                                    });
                                      }
                                   
                                    
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(32),
                                      border: Border.all(
                                        color: index==0
                                        ?Colors.green
                                        :currentIndex==index? Color.fromRGBO(64,123,255,1)
                                        :Color.fromRGBO(173,179,188, 1)
                                        )
                                    ),
                                    width: 91,
                                    height: 32,
                                    child: Text(
                                      dateFormat.format(DateTime.parse(similar[index])),
                                      style: const TextStyle(
                                        fontFamily: "SF",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromRGBO(51, 51, 51, 1)
                                      ),
                                      ),
                                  ),
                                ),
                              );
                                },
                                );
                            },
                            )
                        ),
                
                    ],
                  ),
                ),
                
                  Expanded(

                    child: ListView.builder(
                          itemCount: fullList.length,
                          itemBuilder: (context, index) {
                            return fullList[index];
                           
                          },
                          
                     
                  )
                  )
                
                
        ],
      ),
    );
  }
}