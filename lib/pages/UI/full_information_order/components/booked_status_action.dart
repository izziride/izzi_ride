import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/http/chats/http_chats.dart';
import 'package:temp/http/orders/orders.dart';
import 'package:temp/models/chat/message.dart';
import 'package:temp/pages/UI/app_popup.dart';
import 'package:temp/pages/UI/feedback/feed_back_page.dart';
import 'package:temp/pages/UI/full_information_order/components/booked_error_modal.dart';
import 'package:temp/pages/UI/full_information_order/full_information_order.dart';
import 'package:temp/pages/main/tabs/chat/chat_page.dart';
import 'package:temp/pages/main/tabs/create/card_order/card_order_redact/card_order_redact.dart';
import 'package:temp/pages/main/tabs/profile/user_car/components/create_modal.dart';
import 'package:temp/repository/chats_repo/chats_repo.dart';
import 'package:temp/repository/user_repo/user_repo.dart';

class FO_BookedStatusAction extends StatefulWidget {
  final FullOrderType fullOrderType;
  final UserOrderFullInformation fullUserOrder;
  final int seats;
  int? chatid=null;
   FO_BookedStatusAction({
    super.key,
    required this.fullOrderType,
    required this.seats,
    required this.fullUserOrder,
    this.chatid
    });

  @override
  State<FO_BookedStatusAction> createState() => _FO_BookedStatusActionState();
}

class _FO_BookedStatusActionState extends State<FO_BookedStatusAction> {

  bool tapBlocked=false;
   void update(){
    setState(() {
      
    });
  }

  showErrorBokkedModal(int statusCode){
    showDialog(
      context: context,
      
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
          child: BookedErrorModal(statusCode:statusCode)
          );
      },
      );
  }


  bookOrder(){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child: CreateModal(
            completed: (){
              userRepository.getUserFullInformationOrder(widget.fullUserOrder.orderId);
              userRepository.getUserBookedOrders();
            },
            errorFn: (){},
            future: HttpUserOrder().orderBook(widget.fullUserOrder.orderId,widget.seats),
          ),
        );
      },
      );      
  }

  cancelOrderDriver(){
                                          
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child: CreateModal(
            completed: (){
              if(widget.chatid!=null){
                chatsRepository.updateStatusChat(widget.chatid!);
                Message newmsg=Message(content: "Driver cancelled order", status: 0, frontContentId: "",chatId: widget.chatid!, time:"",id: -1,senderClientId: -1,type: "1" );
                chatsRepository.addMessage(newmsg);
                
              }
              Navigator.pop(context);
            },
            errorFn: (){},
            future: userRepository.cancelOrder(widget.fullUserOrder.orderId, ""),
          ),
        );
      },
      );      
  }
cancelOrderClient(){                                          
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child: CreateModal(
            completed: (){
              userRepository.getUserFullInformationOrder(widget.fullUserOrder.orderId);
              userRepository.getUserBookedOrders();
              Navigator.pop(context);
            },
            errorFn: (){},
            future: HttpUserOrder().orderCancel(widget.fullUserOrder.orderId),
          ),
        );
      },
      );      
  }


  @override
  Widget build(BuildContext context) {
    String? bookedStatus=widget.fullUserOrder.bookedStatus;
    String orderStatus=widget.fullUserOrder.orderStatus;
    print(bookedStatus);
    if(bookedStatus=="canceled"||orderStatus=="canceled"){
      return SizedBox(height: 40,);
    }
    if(widget.fullUserOrder.status=="finished"){
      if(widget.fullOrderType==FullOrderType.user){
        bool isPermission=widget.fullUserOrder.orderRate==0;
         return  GestureDetector(
                          onTap: (){
                            if(!isPermission){
                              return;
                            }
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) => FeedBack(orderId:widget.fullUserOrder.orderId,userIdForRate: widget.fullUserOrder.driverId!,),)
                              );
                          },
                          child: Container(
                                height: 60,
                                margin: EdgeInsets.only(bottom: 30,left: 15,right: 15),
                                width: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(242, 243, 245, 1),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child:isPermission? Text(
                                  "feedback",
                                  style: TextStyle(
                                    color: brandBlue,
                                    fontFamily: "Inter",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600
                                  ),
                                ):Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Rate: ${widget.fullUserOrder.orderRate}",
                                      style: TextStyle(
                                        color: brandBlue,
                                        fontFamily: "Inter",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    Icon(Icons.star,size: 20,color: Color.fromARGB(255, 240, 217, 11))
                                  ],
                                ),
                              ),
                        );
      }
      return SizedBox(height: 40,);
    }
    
    return Column(
      children: [
        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: InkWell(
                            onTap: ()async {
                              if(tapBlocked){
                                return;
                              }
                              tapBlocked=true;
                              if(widget.fullOrderType==FullOrderType.driver){
                                  Navigator.push(context,
                               MaterialPageRoute(builder: (context) => CardOrderReduct(
                                update:update,
                                orderId:widget.fullUserOrder.orderId,
                                carIdInOrder:widget.fullUserOrder.clientAutoId ,
                                preferences:widget.fullUserOrder.preferences,
                                seats:widget.fullUserOrder.seatsInfo.total
                                ),));
                              }else{
                                if(widget.fullUserOrder.bookedStatus=="accepted"){
                                   
                                    int chatId=await HttpChats().getChatId(widget.fullUserOrder.orderId,widget.fullUserOrder.driverId!);
                                    print(chatId);
                                    Navigator.push(
                                      context, 
                                      MaterialPageRoute(builder: (context) => MessagePage(chatId: chatId),)
                                      );
                                }else{
                                  bookOrder();
                                  
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
                                widget.fullOrderType==FullOrderType.driver
                                ?"Edit ride"
                                :widget.fullUserOrder.bookedStatus=="accepted"?"Contact the driver"
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
                        (widget.fullOrderType==FullOrderType.driver||widget.fullUserOrder.bookedStatus=="accepted")? Padding(
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
                                        Navigator.pop(context);
                                        if(widget.fullOrderType==FullOrderType.user){
                                          cancelOrderClient();
                                          
                                        }else{
                                          cancelOrderDriver();
                                          
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
                                widget.fullOrderType==FullOrderType.driver 
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
                     
                        SizedBox(height: 30,),

      ],
    );
  }
}