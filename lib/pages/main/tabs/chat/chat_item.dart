import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/helpers/string_to_color.dart';
import 'package:temp/models/chat/chat_info.dart';
import 'package:temp/repository/user_repo/user_repo.dart';

class ChatItem extends StatefulWidget {
  final ChatInfo chatState;
  final List<int> variableChatId;
  final bool contextMenu;
  const ChatItem({
    required this.chatState,
    required this.contextMenu,
    required this.variableChatId,
    super.key
    });

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
    color: Color.fromARGB(255, 255, 255, 255),
      height: 70,
      child: Row(
        
        children: [
          SizedBox(width: 15,),
          Stack(
            children: [
              Builder(
               
                builder: (context) {
                   final fullname= widget.chatState.chatMembers[0].clientName;
                  return Container(
                    height: 45, width: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: stringToColor(fullname),
                      borderRadius: BorderRadius.circular(45)
                    ),
                    child:Text(
                          fullname[0],
                          style: TextStyle(
                            fontSize: 24
                          ),
                        )
                      
                  );
                }
              ),
              widget.chatState.chatMembers[0].status=="online"?Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: Colors.white,
                      width: 1
                    )
                  ),
                ),
              ):SizedBox.shrink()

            ],
          ),
          SizedBox(width: 12,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.chatState.chatMembers[0].clientName,
                style: TextStyle(
                        fontFamily: "SF",
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(0, 0, 0, 0.87)
                      ),
                
              ),
              Builder(
                builder: (context) {
                  String start="";
                    widget.chatState.start.split(" ").forEach((element) { 
                        start+=element[0].toUpperCase()+element.substring(1);
                        start+=" ";
                    });
                    String end="";
                    widget.chatState.end.split(" ").forEach((element) { 
                        end+=element[0].toUpperCase()+element.substring(1);
                        end+=" ";
                    });
                  return Text(
                    "${start.trimRight()} - ${end.trimRight()}",
                     style: TextStyle(
                        fontFamily: "SF",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 0, 0, 0.87)
                      ),
                  );
                }
              ),
              Builder(
                builder: (context) {
                  final msg=widget.chatState.messages.isNotEmpty?widget.chatState.messages[0].content:"";
                  String text="";
                  if(msg.length>15){
                    text=msg.substring(0,15)+"...";
                  }else{
                    text=msg;
                  }
                  return Text(
                    text,
                     style: TextStyle(
                            fontFamily: "SF",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(0, 0, 0, 0.87)
                          ),
                  );
                }
              )
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Builder(
                  builder: (context) {
                   
                   if(widget.contextMenu){

                      bool isItem=false;
                      for(int chatId in widget.variableChatId){
                        if(widget.chatState.chatId==chatId){
                          isItem=true;
                          break;
                        }
                      }
                      return isItem?Container(
                        width: 20,
                        height: 20,
                        margin: EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: brandBlue,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Icon(Icons.done_outlined,color: Colors.white,size: 10,),
                      ):SizedBox.shrink();
                    }
                    String formattedTime="";
                
                    if(widget.chatState.messages.isNotEmpty){
                         String current_time=widget.chatState.messages[0].time;
                          if(current_time!=""){
                          DateTime time = DateTime.parse(widget.chatState.messages[0].time);
                          print(time);
                          time=time.add(Duration(hours: DateTime.now().timeZoneOffset.inHours));
                          print(time);
                          formattedTime= DateFormat('hh:mm a', 'en_US').format(time);
                          }
                    }
                   
                    return Text(
                      formattedTime
                    );
                  }
                ),
               
                    Builder(
                      
                        builder: (context) {
                          if(widget.contextMenu){
                            return SizedBox.shrink();
                          }
                          //print(widget.chatState.messages[0].status);
                          if(widget.chatState.messages.isNotEmpty && widget.chatState.messages[0].senderClientId==userRepository.userInfo.clienId){
                            int status= widget.chatState.messages[0].status;
                            if(status==-1){
                              return Icon(Icons.query_builder);
                            }
                            if(status==0){
                              return Icon(Icons.done);
                            }
                            if(status==1){
                              return Icon(Icons.done_all);
                            }
                             
                          }
                         
                          return widget.chatState.unreadMsgs>0? Container(
                            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 1),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Text(
                              widget.chatState.unreadMsgs.toString(),
                              style: TextStyle(
                                fontFamily: "SF",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(255, 255, 255, 0.867)
                              ),
                            ),
                          ):SizedBox.shrink();
                        },
                        ),
                 
                
              ],
            ),
          ),
          SizedBox(width: 15,)
        ],
      ),
    );
  }
}