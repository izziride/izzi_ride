
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart' as Launcher;
import 'package:string_to_color/string_to_color.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/http/chats/http_chats.dart';
import 'package:temp/http/orders/orders.dart';
import 'package:temp/pages/UI/app_popup.dart';
import 'package:temp/pages/main/tabs/chat/chat_page.dart';
import 'package:temp/pages/main/tabs/create/card_order/card_order_redact/card_order_redact.dart';
import 'package:temp/pages/main/tabs/search/result_search/bar_navigation.dart';
enum FullOrderType{
  driver,user,none
}
class CardFullOrder extends StatefulWidget{
  final int? seats;
  final FullOrderType? fullOrderType;
  final Function side;
  const CardFullOrder({required this.side, this.seats, this.fullOrderType, required this.startLocation,required this.endLocation,required this.orderId, super.key});

  final String endLocation;
  final int orderId;
  final String startLocation;

  @override
  State<CardFullOrder> createState() => _CardFullOrderState();
}

class _CardFullOrderState extends State<CardFullOrder> {

 Future<void> _launchUniversalLinkIos(double lat,double lng) async {
  bool? visit=await Launcher.MapLauncher.isMapAvailable(Launcher.MapType.apple);
  if (visit!=null && visit) {
  await Launcher.MapLauncher.showMarker(
    mapType: Launcher.MapType.apple,
    coords:  Launcher.Coords(lat, lng),
    title: widget.startLocation,
    
  );
}
  }


  bool tapBlocked=false;

  void update(){
    setState(() {
      
    });
  }

  @override
  void dispose() {
    print("dis");
    super.dispose();
  }

  openModalDeleteUser(String name,int clientId){
        showDialog(
          context: context, 
          builder: (context){
            return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)
                    ),
                    child: AppPopup(warning: false, title: "Delete User?", description: "Do you really want to\ndelete"+name+"?", pressYes: ()async{
                      int result=await HttpUserOrder().deleteUserInOrder(widget.orderId, clientId);
                      print("result: "+result.toString());
                      setState(() {
                        widget.side();
                      });
                      Navigator.pop(context);
                    }, pressNo: ()=>Navigator.pop(context)),
                    );
          }
          );
  }

@override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          BarNavigation(back: true, title: "${widget.startLocation[0].toUpperCase()+widget.startLocation.substring(1)} - ${widget.endLocation[0].toUpperCase()+widget.endLocation.substring(1)}"),
          FutureBuilder<UserOrderFullInformation?>(
              future: HttpUserOrder().getOrderInfo(widget.orderId),
              builder: (context, snapshot) {
                if(snapshot.hasError){
                  return Center(
                    child: Text("error"),
                  );
                  
                }
                if(snapshot.connectionState==ConnectionState.waiting){
                  return CircularProgressIndicator();
                }
                UserOrderFullInformation? fullUserOrder= snapshot.data;
                if(fullUserOrder==null){
                    return Center();
                }
                 FullOrderType fullOrderType=fullUserOrder.isDriver? FullOrderType.driver:FullOrderType.user;
                print(fullUserOrder.automobile.manufacturer);
                 final  _initialCameraPosition=CameraPosition(
                  target: LatLng(
                    fullUserOrder.location[0].latitude,
                    fullUserOrder.location[0].longitude
                    ),
                  zoom: 17  
                    );
                
                DateTime dateTime = DateTime.parse(fullUserOrder.departureTime);
                dateTime=dateTime.add(Duration(hours: DateTime.now().timeZoneOffset.inHours));
                String formattedDate = DateFormat('d MMMM').format(dateTime);
                List<String> dateComponents = formattedDate.split(' ');
                String day = dateComponents[0].padLeft(2, '0');
                String month = dateComponents[1];
                formattedDate = '$day $month';
          
                String formattedTime = DateFormat('HH:mm').format(dateTime);
                formattedTime = formattedTime.split(':').map((segment) => segment.padLeft(2, '0')).join(':');
                print(fullUserOrder.isBooked);
                return  Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 0),
                    child: Column(
                      children: [
                        Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(238, 238, 238, 1),
                                borderRadius: BorderRadius.circular(13)
                              ),
                              
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)
                                    ),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${fullUserOrder.price}0 \$",
                                          style: TextStyle(
                                                          fontFamily: "SF",
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w700,

color: Color.fromRGBO(0, 0, 0, 0.87)
                                                        ),
                                        ),
                                        SizedBox(height: 16,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 4,vertical: 2),
                                                      decoration: BoxDecoration(
                                                        color: Color.fromRGBO(244, 244, 244, 1)
                                                      ),
                                                      child: Text(
                                                        formattedDate,
                                                        style: TextStyle(
                                                          fontFamily: "SF",
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w500,
                                                          color: brandBlack
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 4,),
                                                    Container(
                                                      
                                                      padding: EdgeInsets.symmetric(horizontal: 4,vertical: 2),
                                                      decoration: BoxDecoration(
                                                        
                                                        color: Color.fromRGBO(244, 244, 244, 1)
                                                      ),
                                                      child: Text(
                                                        formattedTime,
                                                        style: TextStyle(
                                                          fontFamily: "SF",
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w500,
                                                          color: brandBlack
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  fullUserOrder.location[0].city,
                                                  style: TextStyle(
                                                          fontFamily: "SF",
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                          color: brandBlack
                                                        ),
                                                )
                                              ],

),
                                            Column(
                                              children: [
                                                Text(
                                                  fullUserOrder.location[1].city,
                                                  style: TextStyle(
                                                          fontFamily: "SF",
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                          color: brandBlack
                                                        ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 9.5,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                width: 7,
                                                height: 7,
                                                decoration: BoxDecoration(
                                                  color: brandBlue,
                                                  borderRadius: BorderRadius.circular(7)
                                                ),
                                            ),
                                            Expanded(
                                              child: DashedLineWidget(windowWidth: MediaQuery.of(context).size.width-100, )
                                              ),
                                              Container(
                                                width: 7,
                                                height: 7,
                                                decoration: BoxDecoration(
                                                  color: brandBlue,
                                                  borderRadius: BorderRadius.circular(7)
                                                ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 16,),
                                        Text(
                                          "Free places ${fullUserOrder.seatsInfo.free}/${fullUserOrder.seatsInfo.total}",
                                          style: TextStyle(
                                                          fontFamily: "SF",
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w500,
                                                          color: brandBlack
                                                        ),
                                        ),
                                        SizedBox(height: 7,),
                                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  for (int i = 0; i < fullUserOrder.seatsInfo.reserved; i++) Padding(
                                    padding: const EdgeInsets.only(right: 5.7),
                                    child: SvgPicture.asset("assets/svg/passenger.svg"),
                                  ),
                                  for (int i = 0; i < fullUserOrder.seatsInfo.free; i++) Padding(
                                    padding: const EdgeInsets.only(right: 5.7),

child: SvgPicture.asset("assets/svg/passanger_empty.svg"),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.17),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SvgPicture.asset("assets/svg/childSeats.svg",color:fullUserOrder.preferences.childCarSeat?Color.fromRGBO(64,123,255,1):Color.fromRGBO(173,179,188,1) ,),
                                        fullUserOrder.preferences.childCarSeat?SizedBox.shrink():Icon(Icons.close,size: 30,weight: 1,color: Color.fromARGB(255, 169, 108, 104) ,)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.17),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SvgPicture.asset("assets/svg/animals.svg",color:fullUserOrder.preferences.animals?Color.fromRGBO(64,123,255,1):Color.fromRGBO(173,179,188,1) ,),
                                        fullUserOrder.preferences.animals?SizedBox.shrink():Icon(Icons.close,size: 30,weight: 2,color: Color.fromARGB(255, 169, 108, 104)  ,)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.17),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SvgPicture.asset("assets/svg/luggage.svg",color:fullUserOrder.preferences.luggage?Color.fromRGBO(64,123,255,1):Color.fromRGBO(173,179,188,1) ,),
                                        fullUserOrder.preferences.luggage?SizedBox.shrink():Icon(Icons.close,size: 30,weight: 2,color: Color.fromARGB(255, 169, 108, 104)  ,)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 0),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SvgPicture.asset("assets/svg/smoking.svg",color:fullUserOrder.preferences.smoking?Color.fromRGBO(64,123,255,1):Color.fromRGBO(173,179,188,1) ,),
                                        fullUserOrder.preferences.smoking?SizedBox.shrink():Icon(Icons.close,size: 30,weight: 2,color: Color.fromARGB(255, 169, 108, 104)  ,)
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                                        
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: fullOrderType==FullOrderType.driver?24:0 ,),
                                  fullOrderType==FullOrderType.driver
                                  ?Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                                    decoration: BoxDecoration(


borderRadius: BorderRadius.circular(12),
                                      color: Colors.white
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Text(
                                            "Passenger data",
                                            style: TextStyle(
                                                            fontFamily: "SF",
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w500,
                                                            color: brandBlack
                                                          ),
                                          ),
                                        ),
                                        fullUserOrder.travelers.length==0
                                        ?
                                        Container(
                                          width: double.infinity,
                                          margin: EdgeInsets.only(top:12,bottom: 12),
                                          height: 82,
                                          child: Column(
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Color.fromRGBO(247, 247, 253, 1)
                                              ),
                                              child: SvgPicture.asset("assets/svg/userSiluete.svg"),
                                            ),
                                            SizedBox(height: 8,),
                                            Text(
                                              "You don't have travel companions yet\nfor a joint ride",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color.fromRGBO(0, 0, 0, 0.6),
                                                fontFamily: "SF",
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14
                                              ),
                                            )
                                            ],
                                          ),
                                        )
                                        : Row(
                                          children: [
                                              for (int i = 0; i < fullUserOrder.travelers.length; i++) 
                                              Padding(
                                                padding: const EdgeInsets.only(right: 10),
                                                child:  Column( children: [
                                                      InkWell(
                                                        onTap: () {
                                                          openModalDeleteUser(fullUserOrder.travelers[i].nickname,fullUserOrder.travelers[i].userId);
                                                        },
                                                        child: Stack(


children: [
                                                            Container(
                                                              margin: EdgeInsets.all(3),
                                                                                                          width: 40,
                                                                                                          height: 40,
                                                                                                          alignment: Alignment.center,
                                                                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(20),
                                                            color: ColorUtils.stringToColor(fullUserOrder.travelers[i].nickname)
                                                                                                          ),
                                                                                                          child: Text(
                                                            fullUserOrder.travelers[i].nickname[0],
                                                            style: TextStyle(
                                                              fontFamily: "SF",
                                                              fontSize: 25,
                                                              
                                                            ),
                                                                                                          ),
                                                                                                           ),
                                                         Positioned(
                                                        top: 0,
                                                        right: 0,
                                                        child: Icon(
                                                          Icons.cancel,
                                                          size: 15,
                                                          color: Colors.red,
                                                          ),
                                                                                                          )
                                                          ],
                                                        ),
                                                      ),
                                                                                              Column(
                                                    children: [
                                                      Text(
                                                        fullUserOrder.travelers[i].nickname,
                                                        textAlign: TextAlign.center,
                                                      )
                                                    ],
                                                                                              )
                                                    ],),
                                               
                                              )
                                            
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                  :SizedBox.shrink(),
                                  SizedBox(height: 24,),
                                  GestureDetector(
                                    onTapDown: (details)=>_launchUniversalLinkIos(_initialCameraPosition.target.latitude,_initialCameraPosition.target.longitude),


child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Start point on the map",
                                            style: TextStyle(
                                                  color: Color.fromRGBO(0, 0, 0, 0.87),
                                                  fontFamily: "SF",
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16
                                                ),
                                          ),
                                          SizedBox(height: 12,),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(18)
                                            ),
                                            height: 140,
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(18),
                                                  child: GoogleMap(
                                                    rotateGesturesEnabled: false,
                                                    initialCameraPosition: _initialCameraPosition,
                                                    scrollGesturesEnabled: false,
                                                    myLocationButtonEnabled:false,
                                                    
                                                    ),
                                                ),
                                                  Center(
                                                    child: SvgPicture.asset("assets/svg/geo.svg"),
                                                  )
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 12,)
                                  ,                                    Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              fullUserOrder.location[0].location,
                                              style: TextStyle(
                                                    color: Color.fromRGBO(0, 0, 0, 0.87),
                                                    fontFamily: "SF",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14
                                                  ),
                                            ),
                                          ),
                                          
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 24,),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),


decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            color: Colors.white
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Ride details",
                                                style: TextStyle(
                                                  color: Color.fromRGBO(0, 0, 0, 0.87),
                                                  fontFamily: "SF",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16
                                                ),
                                              ),
                                              SizedBox(height: 12,),
                                              Container(
                                                padding: EdgeInsets.symmetric(vertical: 12),
                                                alignment: Alignment.centerLeft,
                                                decoration: const BoxDecoration(
                                                  border:Border(
                                                    bottom: BorderSide(
                                                      color: Color.fromRGBO(245, 245, 245, 1),
                                                      width: 1,
                                                      style: BorderStyle.solid
                                                    )
                                                  )
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                     Text(
                                                      "Start point",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(0, 0, 0, 0.87),
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14
                                                      ),
                                                    ),
                                                    SizedBox(height: 4,),
                                                    Text(
                                                      fullUserOrder.location[0].location,
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(0, 0, 0, 0.87),
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 16
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                                 Container(
                                                padding: EdgeInsets.symmetric(vertical: 12),
                                                alignment: Alignment.centerLeft,
                                                decoration: const BoxDecoration(
                                                  border:Border(


bottom: BorderSide(
                                                      color: Color.fromRGBO(245, 245, 245, 1),
                                                      width: 1,
                                                      style: BorderStyle.solid
                                                    )
                                                  )
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                     Text(
                                                      "End point",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(0, 0, 0, 0.87),
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14
                                                      ),
                                                    ),
                                                    SizedBox(height: 4,),
                                                    Text(
                                                      fullUserOrder.location[1].location,
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(0, 0, 0, 0.87),
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 16
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(vertical: 12),
                                                alignment: Alignment.centerLeft,
                                                decoration: const BoxDecoration(
                                                  border:Border(
                                                    bottom: BorderSide(
                                                      color: Color.fromRGBO(245, 245, 245, 1),
                                                      width: 1,
                                                      style: BorderStyle.solid
                                                    )
                                                  )
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                     Text(
                                                      "Number of places",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(0, 0, 0, 0.87),
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14
                                                      ),
                                                    ),
                                                    SizedBox(height: 4,),
                                                    Text(


fullUserOrder.seatsInfo.total.toString(),
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(0, 0, 0, 0.87),
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 16
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),  Container(
                                                padding: EdgeInsets.symmetric(vertical: 12),
                                                alignment: Alignment.centerLeft,
                                                decoration: const BoxDecoration(
                                                  border:Border(
                                                    bottom: BorderSide(
                                                      color: Color.fromRGBO(245, 245, 245, 1),
                                                      width: 1,
                                                      style: BorderStyle.solid
                                                    )
                                                  )
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                     Text(
                                                      "Car",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(0, 0, 0, 0.87),
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14
                                                      ),
                                                    ),
                                                    SizedBox(height: 4,),
                                                    Text(
                                                      fullUserOrder.automobile.manufacturer+" "+fullUserOrder.automobile.model+" ("+fullUserOrder.automobile.year+")",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(0, 0, 0, 0.87),
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 16
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                                 Container(
                                                padding: EdgeInsets.symmetric(vertical: 12),
                                                alignment: Alignment.centerLeft,
                                                decoration: const BoxDecoration(
                                                  border:Border(
                                                    bottom: BorderSide(
                                                      color: Color.fromRGBO(245, 245, 245, 1),
                                                      width: 1,
                                                      style: BorderStyle.solid


)
                                                  )
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                     Text(
                                                      "Comment on the ride",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(0, 0, 0, 0.87),
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14
                                                      ),
                                                    ),
                                                    SizedBox(height: 4,),
                                                    Text(
                                                      fullUserOrder.comment??"",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(0, 0, 0, 0.87),
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 16
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                           
                                            ],
                                          ),
                                        ),
                                       
                                ],
                              ),
                            
                          
                        ),
                        SizedBox(height: 24,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: InkWell(
                            onTap: ()async {
                              if(tapBlocked){
                                return;
                              }
                              tapBlocked=true;
                              if(fullOrderType==FullOrderType.driver){
                                  Navigator.push(context,
                               MaterialPageRoute(builder: (context) => CardOrderReduct(
                                update:update,
                                orderId:widget.orderId,
                                carIdInOrder:fullUserOrder.clientAutoId ,
                                preferences:fullUserOrder.preferences,
                                seats:fullUserOrder.seatsInfo.total
                                ),
                                ));
                              }else{
                                if(fullUserOrder.isBooked){
                                   
                                    int chatId=await HttpChats().getChatId(fullUserOrder.orderId,fullUserOrder.driverId!);
                                    print(chatId);
                                    Navigator.push(
                                      context, 
                                      MaterialPageRoute(builder: (context) => MessagePage(chatId: chatId),)
                                      );
                                }else{
                                  int result= await HttpUserOrder().orderBook(widget.orderId,widget.seats!);
                                  if(result==0){
                                    setState(() {

});
                                  }
                                }
                              }
                              tapBlocked=false;
                              
                            },
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: brandBlue,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Text(
                                fullOrderType==FullOrderType.driver
                                ?"Edit ride"
                                :fullUserOrder.isBooked?"Contact the driver"
                                :"Book a ride",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Inter",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12,),
                        fullOrderType==FullOrderType.driver||fullUserOrder.isBooked? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context, 
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14)
                                    ),
                                    child: AppPopup(warning: false, title: "Cancel ride?", description: "Do you really want to\ncancel your ride?", pressYes: ()async{
                                        int result;
                                        if(fullOrderType==FullOrderType.user){
                                           result = await HttpUserOrder().orderCancel(widget.orderId);
                                        }else{
                                          result=await HttpUserOrder().orderDriverCancel(widget.orderId, "");
                                        }
                                    if(result==0){
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    }
                                    }, pressNo: ()=>Navigator.pop(context)),
                                    );
                                  
                                },
                                );
                            },
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(242, 243, 245, 1),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Text(
                                fullOrderType==FullOrderType.driver 
                                ?"Cancel ride"
                                :"Cancel booking",
                                style: TextStyle(
                                  color: brandBlue,
                                  fontFamily: "Inter",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                          ),
                        )
                        :SizedBox.shrink(),
                        SizedBox(height: 30,)
                      ],
                    ),
                  ),
                );
              },
              
          )
        ],
      ),
    );
  }
}





class DashedLineWidget extends StatelessWidget {
  const DashedLineWidget({super.key, required this.windowWidth});

  final double windowWidth;

  @override
  Widget build(BuildContext context) {
    //18*C+190=windowWidth N=10
    double w=(windowWidth-95)/18;

    //int count=windowWidth ~/20;
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Row(
        
        children: [
            for (int i = 0; i < 18; i++) Container(
                width:w,
                height: 1.5,
                margin: EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
    
                  color: brandBlue,
                  borderRadius: BorderRadius.circular(10)
                ),
            )
        ],
      ),
    );
  }
}