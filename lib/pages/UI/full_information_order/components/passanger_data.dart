import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:string_to_color/string_to_color.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/http/chats/http_chats.dart';
import 'package:temp/http/orders/orders.dart';
import 'package:temp/models/chat/message.dart';
import 'package:temp/pages/UI/app_popup.dart';
import 'package:temp/pages/main/tabs/chat/chat_page.dart';
import 'package:temp/repository/chats_repo/chats_repo.dart';
import 'package:temp/repository/user_repo/user_repo.dart';

class FO_PassangerData extends StatefulWidget {
  final List<Travelers>travelers;
  int? chatid=null;
  final int orderId;
  final String orderStatus;
  FO_PassangerData({super.key,required this.travelers,required this.orderId,this.chatid,required this.orderStatus});

  @override
  State<FO_PassangerData> createState() => _FO_PassangerDataState();
}

class _FO_PassangerDataState extends State<FO_PassangerData> {
  openModalDeleteUser(String name,int clientId,BuildContext context){
        showDialog(
          context: context, 
          builder: (context){
            return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)
                    ),
                    child: AppPopup(warning: false, title: "Delete User?", description: "Do you really want to\ndelete"+name+"?", pressYes: ()async{
                      
                      await userRepository.deleteUserByOrder(widget.orderId, clientId);
                      if(widget.chatid!=null){
                        chatsRepository.updateStatusChat(widget.chatid!);
                         Message newmsg=Message(content: "Driver removed you from order", status: 0, frontContentId: "",chatId: widget.chatid!, time:"",id: -1,senderClientId: -1,type: "1" );
                        chatsRepository.addMessage(newmsg);
                        
                      }
                      Navigator.pop(context);
                    }, pressNo: ()=>Navigator.pop(context)),
                    );
          }
          );
  }




  void ratePeople(BuildContext context,Travelers travelers){
    showDialog(
      context: context, 
      builder: (context) {
        return Dialog(
          child: FeedBackModal(travelers: travelers,orderId: widget.orderId,)
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(vertical: 12,horizontal: 1),
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
                                        widget.travelers.length==0
                                        ?
                                        Container(
                                          width: double.infinity,
                                          margin: EdgeInsets.only(top:12,bottom: 12),
                                          height: 88,
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
                                        : Column(
                                          children: [
                                              
                                              for (int i=0,a = -(widget.travelers.length-1); a < widget.travelers.length; a++,i++ ) 
                                              i%2==1?Container(height: 2,color: const Color.fromARGB(255, 214, 214, 214),margin: EdgeInsets.symmetric(horizontal: 5,vertical: 15),) :
                                              Padding(
                                                padding: const EdgeInsets.only(right: 10),
                                                child:  Row( 
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                              margin: EdgeInsets.all(3),
                                                              width: 40,
                                                              height: 40,
                                                              alignment: Alignment.center,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(20),
                                                                color: ColorUtils.stringToColor(widget.travelers[((i+1)/2).toInt()].nickname)
                                                              ),
                                                              child:Text(
                                                                      widget.travelers[((i+1)/2).toInt()].nickname[0],
                                                                      style: TextStyle(
                                                                        fontFamily: "SF",
                                                                        fontSize: 25,
                                                                      ),
                                                                    ),
                                                            ),
                                                
                                                         
                                                      
                                                      SizedBox(width: 10,),
                                                      Text(
                                                        widget.travelers[((i+1)/2).toInt()].nickname,
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      SizedBox(width: 10,),
                                                      Text(
                                                        widget.travelers[((i+1)/2).toInt()].rate==0?"0":widget.travelers[((i+1)/2).toInt()].rate.toString(),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                        Icon(Icons.star,size: 20,color: Color.fromARGB(255, 240, 217, 11))
                                                      ],
                                                    ),
                                                      
                                                      widget.orderStatus!="finished"?Row(
                                                        children: [
                                                          Column(
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () async{
                                                                  int chatId=await HttpChats().getChatId(widget.orderId,widget.travelers[((i+1)/2).toInt()].userId);
                                                                    
                                                                    Navigator.push(
                                                                      context, 
                                                                      MaterialPageRoute(builder: (context) => MessagePage(chatId: chatId),)
                                                                      );
                                                                },
                                                                child: Icon(Icons.message,color: brandBlue,size: 20)),
                                                            ],
                                                          ),
                                                          SizedBox(width: 10,),
                                                          Column(
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                    openModalDeleteUser(widget.travelers[((i+1)/2).toInt()].nickname,widget.travelers[((i+1)/2).toInt()].userId,context);
                                                                  },
                                                                child: Icon(Icons.dangerous,color: Colors.red,size: 20,)),
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                      :Row(
                                                        children: [
                                                          widget.travelers[((i+1)/2).toInt()].driverRate==null
                                                          ? GestureDetector(
                                                            onTap:()=> ratePeople(context,widget.travelers[((i+1)/2).toInt()]),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                color: brandBlue,
                                                                borderRadius: BorderRadius.circular(12)
                                                              ),
                                                              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                                              child: Text(
                                                                "RATE",
                                                                textAlign: TextAlign.center,
                                                                style:  TextStyle(
                                                                  color: Colors.white,
                                                                  fontFamily: "SF",
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: 14
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                          :Builder(
                                                            builder: (context) {

                                                              int variableCount=0;
                                                              variableCount= widget.travelers[((i+1)/2).toInt()].driverRate!.toInt();
                                                              return Row(
                                                                children: [
                                                                  // Container(
                                                                  //   width: 1.5,
                                                                  //   height: 15,
                                                                  //   color: Colors.black,
                                                                  // ),
                                                                  SizedBox(width: 10,),
                                                                  Text(
                                                                    "RATE: ${variableCount}",
                                                                    textAlign: TextAlign.center,
                                                                    style:  TextStyle(
                                                                      fontFamily: "SF",
                                                                      fontWeight: FontWeight.w400,
                                                                      fontSize: 14
                                                                    ),
                                                                  ),
                                                                  tappedStar(true),
                                                                  // for(int j=0;j<variableCount;j++)
                                                                  // tappedStar(true),
                                                                  // for(int j=0;j<5-variableCount;j++)
                                                                  // tappedStar(false),
                                                                ],
                                                              );
                                                            },
                                                          ),
                                                          
                                                          
                                                          
                                                        ],
                                                      ),

                                                    ],),
                                               
                                              )
                                            
                                          ],
                                        )
                                      ],
                                    ),
                                  );
  }
Widget tappedStar(bool variable){
      return Icon(Icons.star,size: 20,color: variable?Color.fromARGB(255, 240, 217, 11):Color.fromARGB(144, 158, 158, 158)
      );
    }
 
}



class FeedBackModal extends StatefulWidget {
  final Travelers travelers;
  final int orderId;
  const FeedBackModal({super.key,required this.travelers,required this.orderId});

  @override
  State<FeedBackModal> createState() => _FeedBackModalState();
}

class _FeedBackModalState extends State<FeedBackModal> {


  void feedPeople()async{
    final result=await HttpUserOrder().rateUser(widget.orderId, "", feedBack+1, widget.travelers.userId);
    if(result==0){
      userRepository.getUserFullInformationOrder(widget.orderId);
    }
    feedBack=-1;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            height: 300,
            child: Column(
              children: [
                SizedBox(height: 20,),
                Text(
                  "Rate "+widget.travelers.nickname,
                  style: TextStyle(
                            fontFamily: "SF",
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: brandBlack
                          ),
                          
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      tappedStar(0),
                      tappedStar(1),
                      tappedStar(2),
                      tappedStar(3),
                      tappedStar(4),               
                    ],
                  ),
                ),
                feedBack!=-1? GestureDetector(
                  onTap: feedPeople,
                  child: Container(
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                      color: brandBlue,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    
                    alignment: Alignment.center,
                    child:  Text(
                      "OK",
                      textAlign: TextAlign.center,
                      style:  TextStyle(
                        color: Colors.white,
                        fontFamily: "SF",
                        fontWeight: FontWeight.w400,
                        fontSize: 14
                      ),
                    ),
                  ),
                ):SizedBox(height: 40,),
                SizedBox(height: 30,)
              ],
            ),
          );
  }

    int feedBack=-1;
    Widget tappedStar(int index){
      return GestureDetector(
        onTap: () {
          setState(() {
            feedBack=index;
          });
        },
        child: Icon(Icons.star,size: 50,color: feedBack>=index?Color.fromARGB(255, 240, 217, 11):Color.fromARGB(144, 158, 158, 158),)
      );
    }
}