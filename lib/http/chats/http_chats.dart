import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:temp/http/instanse.dart';
import 'package:temp/localStorage/tokenStorage/token_storage.dart';
import 'package:temp/models/chat/chat_info.dart';
import 'package:temp/models/chat/chat_members.dart';
import 'package:temp/models/chat/message.dart';
import 'package:uuid/uuid.dart';


const baseUrl="https://ezride.pro/api/v1/client/chats";
const chatUrl="https://ezride.pro/api/v1/chat";
const baseAppUrl="https://ezride.pro/api/v1";
const fcmTokenUrl="https://ezride.pro/api/v1/push-token";


class UserChatInfo{
  String nickname;
  String photoUri;
  String state;
  UserChatInfo({
    required this.nickname,
    required this.photoUri,
    required this.state
  });
}

class HttpChats{

    Dio dio=Dio();
    HttpChats(){
      final authInterceptor=AuthInterceptor(dio);
      dio.interceptors.add(authInterceptor);
    }

    Future<int> deleteChat(int chatId)async{

        String access= tokenStorage.accessToken;
        
        try {
          Response response= await dio.delete(
          chatUrl+"/${chatId}",
          options: Options(
          headers: {
            "Authorization":"Bearer $access"
          }
        )
          );  
          return 0;
        } catch (e,stackTrace) {
          print(e);
          Sentry.captureException(
            e,
            stackTrace: stackTrace,
          );
          return -1;

        }
    }

    Future<ChatInfo?> getUserChat(int chatId)async{
      String access= tokenStorage.accessToken;
      try {
        Response response=await dio.get(
        "https://ezride.pro/api/v1/chat/${chatId}",
        options: Options(
          headers: {
            "Authorization":"Bearer $access"
          }
        )
      );
      print("response");
      print(response.data);
      if(response.data["data"]==null){
        return null;
      }
      ChatInfo userChats;
      Map<String,dynamic> mocked=response.data["data"];
      List<dynamic> chatMembersUntyped=mocked["members"];
      List<ChatMembers> chatMembers=chatMembersUntyped.map((chtm)=>
        ChatMembers(clienId: chtm["client_id"], clientName: chtm["client_name"]??"name", photoUri: chtm["photo"]??"photo", status: "online")
      ).toList();
      Message mess=Message(
              chatId: mocked["chat_id"], 
              content: mocked["message"]["content"]??"", 
              frontContentId: mocked["message"]["front_content_id"]??"", 
              id: mocked["message"]["id"]??-1, 
              senderClientId: mocked["message"]["client_id"]??-1, 
              time: mocked["message"]["message_time"]??"", 
              type: mocked["message"]["type"]??"10", 
              status: mocked["message"]["status"]??-1
              );
      userChats= ChatInfo(
          deactivate: mocked["chat_status"]??false,
          orderId: mocked["order_id"], 
          chatId: mocked["chat_id"], 
          unreadMsgs: mocked["unread_messages"],
          start: mocked["start"]??"start", 
          end: mocked["end"]??"end", 
          createdAt: mocked["created_at"],
          chatMembers: chatMembers,
          message:mess,
          messages: [mess]
          );
      
      return userChats;
      } catch (e,stackTrace) {
        print(e);
        Sentry.captureException(
          e,
          stackTrace: stackTrace,
        );
        return null;
      }
    } 

    Future<List<ChatInfo>> getUserChats()async{
      String access= tokenStorage.accessToken;
      try {
        Response response=await dio.get(
        baseUrl,
        options: Options(
          headers: {
            "Authorization":"Bearer $access"
          }
        )
      );
      print("response");
      print(response.data);
      if(response.data["data"]==null){
        return [];
      }
      List<ChatInfo> userChats=[];
      List<dynamic> mockedList=response.data["data"];
      userChats= mockedList.map(
        (el){
          List<dynamic> chatMembersUntyped=el["members"];
          List<ChatMembers> chatMembers=chatMembersUntyped.map((chtm)=>
            ChatMembers(clienId: chtm["client_id"], clientName: chtm["client_name"]??"name", photoUri: chtm["photo"]??"photo", status: "online")
          ).toList();
          Message mess=Message(
              chatId: el["chat_id"], 
              content: el["message"]["content"]??"", 
              frontContentId: el["message"]["front_content_id"]??"", 
              id: el["message"]["id"]??-1, 
              senderClientId: el["message"]["client_id"]??-1, 
              time: el["message"]["message_time"]??"", 
              type: el["message"]["type"]??"1", 
              status: el["message"]["status"]??-2
              );
         return ChatInfo(
          deactivate: el["chat_status"]??true,
          orderId: el["order_id"], 
          chatId: el["chat_id"], 
          unreadMsgs: el["unread_messages"],
          start: el["start"]??"start", 
          end: el["end"]??"end", 
          createdAt: el["created_at"],
          chatMembers: chatMembers,
          message:mess,
          messages: mess.id==-1?[]:[mess]
          );
        }
          ).toList();
      return userChats;
      } catch (e,stackTrace) {
        print(e);
        Sentry.captureException(
          e,
          stackTrace: stackTrace,
        );
        return [];
      }
    } 

    Future<int> getChatId(int orderId,int clientId)async{

        String access= tokenStorage.accessToken;
        
        try {
          Response response= await dio.post(
          chatUrl,
          data: {
            "order_id":orderId,
            "client_id":clientId
          },
          options: Options(
          headers: {
            "Authorization":"Bearer $access"
          }
        )
          );  
          print(response);
          int chatId=response.data["data"]["chat_id"];
          return chatId;
        } catch (e,stackTrace) {
          print(e);
          Sentry.captureException(
            e,
            stackTrace: stackTrace,
          );
          return -1;

        }
    }

    Future<UserChatInfo?> getUserInfo(int userId)async{
      String access= tokenStorage.accessToken;
      try {
        Response response=await dio.get(
          "$chatUrl/client/$userId",
          options: Options(
          headers: {
            "Authorization":"Bearer $access"
          }
        )
        );
        print(response);
        final res=response.data["data"];
        UserChatInfo userChatInfo=UserChatInfo(
          nickname: res["nickname"],
          photoUri: res["photo_url"],
          state: res["state"]
        );
        return userChatInfo;
      } catch (e,stackTrace) {
        print(e);
        Sentry.captureException(
          e,
          stackTrace: stackTrace,
        );
        return null;
      }
    }

    Future<int> setFcmToken(String token, )async{
      String access= tokenStorage.accessToken;
      String platform="";
        if(Platform.isAndroid){
          platform="android";
        }else if(Platform.isIOS){
          platform="ios";
        }
      try {
        Response response=await dio.put(
        fcmTokenUrl,
        data: {
          "token":token,
          "platform":platform
        },
        options: Options(
          headers: {
            "Authorization":"Bearer $access"
          }
        )
        );
        print(response.data);
        return 0;
      } catch (e,stackTrace) {
        print(e);
        print("err fcm");
        Sentry.captureException(
          e,
          stackTrace: stackTrace,
        );
        return 1;
      }
    }

    Future<List<Message>> getChatMessage(int chatId,int messageId)async{
      String access= tokenStorage.accessToken;
      try {
        Response response=await dio.get(
          "$baseAppUrl/chat/history/$chatId",
          queryParameters: {
            "message_id":messageId
          },
          options: Options(
          headers: {
            "Authorization":"Bearer $access"
          }
        )
        );
        print(response.data);
        List<dynamic> listDinamic = response.data["data"]["messages"]??[];
        ;
       List<Message>listMessage= listDinamic.map((el)=>
              Message(
                senderClientId: el["client_id"],
                id: el["message_id"],
                content: el["message"], 
                status: 1,
                frontContentId: Uuid().v4(), 
                chatId: response.data["data"]["chat_id"], 
                time: el["created_at"],
                type: el["message_type"]??"1"
                )).toList();
                return listMessage;
      } catch (e,stackTrace) {
        print("error messs");
        print(e);
        Sentry.captureException(
          e,
          stackTrace: stackTrace,
        );
        return [];
      }
    }


  Future<ChatInfo?> getChatInfo(int chatId)async{
      String access= tokenStorage.accessToken;
      try {
        Response response=await dio.get(
          "$chatUrl/$chatId",
          options: Options(
          headers: {
            "Authorization":"Bearer $access"
          }
        )
        );
        print(response.data);
        final t_chatInfo=response.data["data"];
          List<dynamic> t_chatMembers=t_chatInfo["chat_members"];
          List<ChatMembers> chatMembers= t_chatMembers.map((member)=>
            ChatMembers(
              clienId: member["client_id"], 
              clientName: member["client_name"], 
              photoUri: member["photo"], 
              status: member["status"]
              )
          ).toList();
       
          ChatInfo chatInfo=ChatInfo(
            deactivate: t_chatInfo["deactivate"]??false,
            chatId: t_chatInfo["chat_id"], 
            chatMembers: chatMembers, 
            createdAt: t_chatInfo["created_at"], 
            end: t_chatInfo["end_location"], 
            orderId: t_chatInfo["order_id"], 
            start: t_chatInfo["start_location"],
            messages: [],
            message: t_chatInfo["message"],
            unreadMsgs: t_chatInfo["unread_messages"]
            );
        return chatInfo;
      } catch (e,stackTrace) {
        print(e);
        Sentry.captureException(
          e,
          stackTrace: stackTrace,
        );
        return null;
      }
    }

}



