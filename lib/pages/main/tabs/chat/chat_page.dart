
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/helpers/string_to_color.dart';
import 'package:temp/models/chat/chat_info.dart';
import 'package:temp/models/chat/message.dart';
import 'package:temp/pages/UI/full_information_order/full_information_order.dart';
import 'package:temp/repository/chats_repo/chats_repo.dart';
import 'package:temp/repository/user_repo/user_repo.dart';
import 'package:temp/socket/socket.dart';
class MessagePage extends StatefulWidget{
  final int chatId;
  const MessagePage({required this.chatId, super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {

  TextEditingController _msgController= TextEditingController();
  ScrollController _controller =ScrollController();
  FocusNode _focusNode=FocusNode();



  @override
  void initState() {
    
    super.initState();
  }  

  @override
  void dispose() {
   _msgController.dispose();
   chatsRepository.updateCurrentChatId(-1);
    super.dispose();
  }

  void sendMessage()async{
   await appSocket.sendMessage(
      _msgController.text,
      widget.chatId,

    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
  
  _controller.jumpTo(
    _controller.position.minScrollExtent, 
  );
});
    _msgController.text="";
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset:true,
        appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            toolbarHeight: 0,
            backgroundColor: Colors.white,
            toolbarOpacity: 0,
            elevation: 0,
            
        ),
        body: 
           GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
             child: Column(
              children: [
                Observer(
                  builder: (context) {
                    
                    ChatInfo? chatInfo=chatsRepository.chats[widget.chatId.toString()];
                    if(chatInfo==null){
                      chatsRepository.getChat(widget.chatId);
                      return SizedBox.shrink();
                    }
                     
                    return Container(
                      height: 55,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(226,226,226, 1),
                            width: 1
                          )
                        )
                      ),
                      child: Row(
                          children:[
                            Padding(
                              padding: const EdgeInsets.only(left: 10,right: 11),
                              child: InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                } ,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 40,
                                  child: SvgPicture.asset(
                                  "assets/svg/back.svg"
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                height: 45, width: 45,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: stringToColor(chatInfo.chatMembers[0].clientName),
                                  borderRadius: BorderRadius.circular(45)
                                ),
                                child:Text(
                                      chatInfo.chatMembers[0].clientName[0],
                                      style: TextStyle(
                                        fontSize: 24
                                      ),
                                    )
                                  
                              ),
                            
                           Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                chatInfo.chatMembers[0].clientName,
                                style: TextStyle(
                                  fontFamily: "SF",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16
                                ),
                                ),
                              Text(
                                chatInfo.chatMembers[0].status,
                                style: TextStyle(
                                  fontFamily: "SF",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color.fromRGBO(58,121,215,1)
                                ),
                                )
                            ],
                                        ),
                          ),
                          ]
                          
                        )
                    );
                  }
                ),
                Container(
                  height: 65,

              padding: EdgeInsets.only(left: 19.5),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromRGBO(226,226,226, 1),
                        width: 1
                      )
                    )
                  ),
                  child:Observer(
                    builder: (context) {

                      ChatInfo? chatInfo=chatsRepository.chats[widget.chatId.toString()];
                    if(chatInfo==null){
                      return SizedBox.shrink();
                    }
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                           MaterialPageRoute(builder: (context) => CardFullOrder(
                            chatid: widget.chatId,
                            side: (){},
                            startLocation: chatInfo.start, 
                            endLocation: chatInfo.end, 
                            orderId: chatInfo.orderId,

                            ),
                            )
                            );
                        },
                        
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  
                                  width: MediaQuery.of(context).size.width-75,
                                  child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top:8),
                                      child: Column(
                                        
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Observer(
                                          
                                          builder: (context) {

                                          String formattedTime="";
                                          String formattedDate="";
                                          String current_time=chatsRepository.chats[widget.chatId.toString()]!.createdAt;
                                          print(current_time);
                                          if(current_time!=""){
                                          DateTime time = DateTime.parse(current_time);
                                          print(time.toString());
                                          print(time.month);
                                          time= time.add(Duration(hours: DateTime.now().timeZoneOffset.inHours));
                                          formattedTime= DateFormat('hh:mm a', 'en_US').format(time);
                                          formattedDate= DateFormat('yyyy.MM.dd', 'en_US').format(time);
                                          }

                                            return Row(
                                              children: [
                                                Container(
                                                  height: 17,
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(2),
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
                                                SizedBox(width: 8,),
                                                 Container(
                                                  height: 17,
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(2),
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
                                            );
                                          }
                                        ),
                                        SizedBox(height: 4,),
                                        Text(
                                         chatInfo.start[0].toUpperCase()+chatInfo.start.substring(1),
                                         style: TextStyle(
                                            fontFamily: "SF",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: brandBlack
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                      ],
                                                              ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:19),
                                      child: Column(
                                        
                                      children: [
                                        
                                        Text(
                                          chatInfo.end[0].toUpperCase()+chatInfo.end.substring(1),
                                          style: TextStyle(
                                            fontFamily: "SF",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: brandBlack
                                          ),
                                        )
                                      ],
                                                              ),
                                    ),
                                  ],
                                ) 
                                ),
                                Row(
                                  children: [
                                   
                                  Container(
                                        height: 7,
                                        width: 7,
                                        decoration: BoxDecoration(
                                          color: brandBlue,
                                          borderRadius: BorderRadius.circular(7)
                                        ),
                                      ),
                                      DashedLineWidget(windowWidth: MediaQuery.of(context).size.width-89),
                                       Container(
                                        height: 7,
                                        width: 7,
                                        decoration: BoxDecoration(
                                          color: brandBlue,
                                          borderRadius: BorderRadius.circular(7)
                                        ),
                                      )
                                   
                                  ],
                                )
                              ],
                            ),
                            
                            Expanded(
                              
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 12),
                                child: SvgPicture.asset(
                                  "assets/svg/chevron-left.svg",
                                  color: brandBlue,
                                  ),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: KeyboardListener(
                          focusNode: _focusNode,
                          onKeyEvent: (value) {
                           
                          },

                  child: Stack(
                    children: [
                      SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Image.asset("assets/image/bg5.png",width: 20,height: 20, repeat: ImageRepeat.repeat,)
                          ),
                      Observer(
                        builder: (context) {
                            ChatInfo? chatInfo=chatsRepository.chats[widget.chatId.toString()];
                          if(chatInfo==null){
                            return SizedBox.shrink();
                          }
                          List<Message> messages=chatInfo.messages;
                          if(messages.length==1){
                           // chatsRepository.getMessageInchats(widget.chatId);
                          }
                          String reg="Driver removed you from order";
                          return ListView.builder(
                                    reverse: true,
                                    
                                    controller: _controller,
                                            itemCount: messages.length,
                                            itemBuilder: (context, index) {
                                              
                                              print(messages[index].type);
                                              if(messages[index].type=="10"){
                                                return SizedBox.fromSize();
                                              }
                                              if(messages[index].type=="1"){
                                                return Container(
                                                  alignment: Alignment.center,
                                                  margin: EdgeInsets.symmetric(horizontal: 30,vertical:10 ),
                                                  padding: EdgeInsets.only(left: 10,top: 5,bottom: 5),
                                                  decoration: BoxDecoration(
                                                    color: Color.fromARGB(66, 0, 0, 0),
                                                    borderRadius: BorderRadius.circular(20)
                                                  ),
                                                  child: Text(
                                                            messages[index].content,
                                                            style: TextStyle(
                                                              color: Color.fromARGB(255, 255, 255, 255),
                                                              fontFamily: "SF",
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                );
                                              }
                                              return  Padding(
                                                  padding: EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 10),
                                                  child:  Container(
                                                    
                                                    alignment:messages[index].senderClientId!=userRepository.userInfo.clienId?Alignment.centerLeft:Alignment.centerRight,
                                                    child: Stack(
                                                      alignment:messages[index].senderClientId==userRepository.userInfo.clienId? Alignment.bottomRight:Alignment.bottomLeft,
                                                      children: [
                                                        Container(
                                                          
                                                          margin:messages[index].senderClientId==userRepository.userInfo.clienId? EdgeInsets.only(right: 5):EdgeInsets.only(left: 5),
                                                          decoration: BoxDecoration(
                                                              color: messages[index].senderClientId==userRepository.userInfo.clienId?Color.fromRGBO(0, 122, 255, 1):Color.fromRGBO(229, 229, 234, 1),
                                                              borderRadius: BorderRadius.circular(15)
                                                          ),
                                                          constraints: BoxConstraints(
                                                            minWidth: 100,
                                                            maxWidth: 234
                                                          ),
                                                          padding: EdgeInsets.only(left: 14,right: 30,top: 7, bottom: 7),
                                                            
                                                          child: Text(
                                                            messages[index].content,
                                                            style: TextStyle(
                                                              color: messages[index].senderClientId==userRepository.userInfo.clienId?Colors.white:Colors.black,
                                                              fontFamily: "SF",
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: 17,
                                                              letterSpacing: -0.41
                                                            ),
                                                          ),
                                                        ),
                                                        messages[index].senderClientId==userRepository.userInfo.clienId?Image.asset("assets/image/tailBlue.png"):Image.asset("assets/image/tailGray.png"),
                                                        messages[index].senderClientId==userRepository.userInfo.clienId? Positioned(
                                                          bottom: 5,
                                                          right: 15,
                                                          child: Icon(messages[index].status==1?Icons.done_all: messages[index].status==-1?Icons.query_builder: Icons.done,size: 15,color: Colors.white,)//SvgPicture.asset("assets/svg/status_0.svg",color: Colors.white,width: 10,height: 10),
                                                        ):SizedBox.shrink(),
                                                        
                                                      ],
                          
                          ),
                                                  ),
                                                );
                                              
                                            },
                        );
                        }
                      ),
                       
                        
                    ],
                  ),
                        )
                       ),
                      Observer(
                        builder: (context) {
                          bool deactivate = chatsRepository.chats[widget.chatId.toString()]?.deactivate??false;
                          print("STATUS CHAT "+deactivate.toString());
                          return Container(
                            height: 67.25,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 27.67,right: 15, bottom: 20),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(248, 248, 248, 1),
                              border: Border(
                                top: BorderSide(
                                  color: Color.fromRGBO(179, 179, 179, 1),
                                  width: 1,
                                  style: BorderStyle.solid
                                )
                              )
                            ),
                            child: !deactivate
                            ?Text(
                                      "Chat is deactivate",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: "SF",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14
                                      ),
                                    )

                            :Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextField(
                                    focusNode: _focusNode,
                                    controller: _msgController,
                                    textInputAction:TextInputAction.send,
                                    onEditingComplete:(){
                                        sendMessage();
                                    },
                                   
                                    style: TextStyle( 
                                      color: brandBlack,
                                      fontSize: 17
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Type your message here..",
                                      hintStyle: TextStyle(
                                        color: brandGrey
                                      )
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                   sendMessage();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    child: Text(
                                      "Send",
                                      style: TextStyle(
                                        color: brandBlue,
                                        fontFamily: "SF",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                      )
                    ],
                  ),
                )
              ],
              ),
           ),
        
      );
  }
}

// Shimmer.fromColors(
//                                         baseColor: Colors.grey[300]!,
//                                         highlightColor: Colors.grey[100]!,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(21),
//                                       color: brandGrey
//                                     ),
//                                     height: 42,
//                                     width: 42,
                                   
//                                   ),
//                                 )