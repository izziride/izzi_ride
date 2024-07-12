import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:temp/localStorage/tokenStorage/token_storage.dart';
import 'package:temp/models/chat/chat_info.dart';
import 'package:temp/models/chat/message.dart';
import 'package:temp/repository/chats_repo/chats_repo.dart';
import 'package:temp/repository/user_repo/user_repo.dart';
import 'package:uuid/uuid.dart';

class SocketMessage{
  String type;
  SocketMessage({
    required this.type
  });
}





class SocketProvider {
  WebSocket? channel;
  Uuid uuid=const  Uuid();
  static bool isConnect=false;


  void connect()async{
    try {
      
    WebSocket conn =await WebSocket.connect("wss://ezride.pro/api/v1/chat/join");
    conn.pingInterval=Duration(seconds: 1);
    channel=conn;
    SocketProvider.isConnect=true;
    chatsRepository.getChats();
    channel!.listen((event) async{ 
     
      print("socket!");
      print(event+"///");
      if(event=="token not valid"){
          return;
        }
        final parseMessage=json.decode(event);
        
        SocketMessage message=SocketMessage(type: parseMessage["type"]);
        if(message.type=="connection"){
            final token=tokenStorage.accessToken;
            final message=json.encode({
              "token":token,
              "type":"auth"
            });
            print(message);
              channel?.add(message);
        }
        if(message.type=="auth"){
          print("SOCKET CONNECT");
          //checkUnread();
         
            // final message = json.encode({
            //   "client_id":122,
            //   "front_hash_id":1,
            //   "type":"message",
            //   "chat_id":4,
            //   "content":"211"
            // });
            // channel.sink.add(message);
            
              
        }
        if(message.type=="cancel-client"){
          Map<String,dynamic> booking=json.decode(event);
          int orderId=booking["order_id"]??-1;
          
          print("DELETEEE");
        }
        if(message.type=="booking"){
          Map<String,dynamic> booking=json.decode(event);
          int orderId=booking["orderId"];
          // int newStatus
          // userRepository.editStatusOrder(orderId, newStatus)
          print("DELETEEE");
        }
        if(message.type=="booking_driver"){
          Map<String,dynamic> bookingDriver=json.decode(event);
          int orderId=bookingDriver["order_id"];
          String statusName=bookingDriver["status_name"];
          userRepository.editUserOrdersSeatsInOrder(orderId,statusName);
        }
        if(message.type=="cancel-client"){
          Map<String,dynamic> cancelClient=json.decode(event);
          int senderId=cancelClient["sender_id"];
          String time=cancelClient["sent_time"];
          int orderId=cancelClient["order_id"];
          userRepository.cancelBookedOrderByUser(orderId);
          int chatId=cancelClient["chat_id"]??-1;
          if(chatId==-1 || chatsRepository.chats[chatId.toString()]==null){
            return;
          }
          Message newmsg=Message(content: "Driver removed you from order", status: 0, frontContentId: "",chatId: chatId, time:time,id: -1,senderClientId: -1,type: "1" );
          chatsRepository.addMessage(newmsg);
          chatsRepository.updateStatusChat(chatId);
          // chatsRepository.chats.forEach((key, value) { 
          //   if(value.orderId==)
          // });

         
        }
        if(message.type=="cancel-order"){
          Map<String,dynamic> cancelClient=json.decode(event);
          int senderId=cancelClient["sender_id"];
          String time=cancelClient["sent_time"];
          int orderId=cancelClient["order_id"];
          userRepository.cancelBookedOrderByUser(orderId);
          int chatId=cancelClient["chat_id"]??-1;
          if(chatId==-1 || chatsRepository.chats[chatId.toString()]==null){
            return;
          }
          Message newmsg=Message(content: "Driver cancelled order", status: 0, frontContentId: "",chatId: chatId, time:time,id: -1,senderClientId: -1,type: "1" );
          chatsRepository.addMessage(newmsg);
          chatsRepository.updateStatusChat(chatId);
        }
        if(message.type=="message-itself"){
          Map<String,dynamic> statusMsg=json.decode(event);
          int status=statusMsg["status"];
          int messageId=statusMsg["content_id"];
            int chatId=statusMsg["chat_id"];
            String time=statusMsg["sent_time"];
            print(time);
            String frontContentId=statusMsg["front_content_id"];
            chatsRepository.editStatus(chatId.toString(), status, frontContentId, time);
           // editStatus(chatId,uuId,status);
          
        }
        if(message.type=="message"){
          Map<String,dynamic> mess=json.decode(event);
          print(mess);
           String newUuid=uuid.v4();
           Message newmsg=Message(content: mess["content"], status: mess["status"], frontContentId: mess["front_content_id"],chatId: mess["chat_id"], time:mess["sent_time"],id: mess["content_id"],senderClientId: mess["sender_id"],type: mess["type"] );
          chatsRepository.addMessage(newmsg);
        }
        
        if(message.type=="full-read"){
           Map<String,dynamic> mess=json.decode(event);
            chatsRepository.fullRead(mess["chat_id"].toString());

        }

   },
   onError: (error){
        print("eDISCONNECT");
          if(error is SocketException){
            print(error);
          }
      },
      onDone: () {
        print("DISCONNECT");
         if(channel!=null){
            channel!.close();

          }
     SocketProvider.isConnect=false;
      print("Повторное подключение");
      Future.delayed(Duration(seconds: 1)).then((value){
        print("reconnect onDONE");
        if(!SocketProvider.isConnect){
            connect();
        }
        
      });

      },
   );
    
    } catch (e) {
      print(e);
     if(channel!=null){
       channel!.close();

     }
     SocketProvider.isConnect=false;
      print("Повторное подключение");
      Future.delayed(Duration(seconds: 1)).then((value){
        print("reconnect CATCH");
         if(!SocketProvider.isConnect){
            connect();
        }
      });
    }
      
   }

  void resendMessage(Message element){

  }



  Future<void> sendMessage(String text,int chatId)async{
    String currUuid=uuid.v4();
    print(chatId);
    Map<String,dynamic> message={
      "front_content_id": currUuid,
      "type":"message",
      "content":text,
      "chat_id":chatId
    };
    print(message);
    Message newMsg= Message(content: text, status: -1, frontContentId: currUuid, chatId: chatId, time: "",id:-1,senderClientId: userRepository.userInfo.clienId,type: "0");

    //editMessage(newMsg,false);
    chatsRepository.addMessage(newMsg);
    if(SocketProvider.isConnect==false){
      return;
    }
     channel?.add(json.encode(message));
     
  }

  fullReadMessage(int chatId){
    print("send read");
    Map<String,dynamic> read={
      "chat_id":chatId,
      "type":"message-read"
     };
     print(json.encode(read));
     channel?.add(json.encode(read));
  }


}

SocketProvider appSocket=SocketProvider();