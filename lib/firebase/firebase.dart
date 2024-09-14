import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:temp/http/chats/http_chats.dart';
import 'package:temp/http/token/http_token.dart';

class FirebaseDriver{

  init()async{
    String? token = await FirebaseMessaging.instance.getToken();
    print(token);
    if(token!=null){
      await HttpChats().setFcmToken(token);
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    inspect(message);

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
    });
    final apnsToken = await FirebaseMessaging.instance.getToken();
    print("FB");
    print(apnsToken);
    if(apnsToken!=null){
      String platform="";
      if(Platform.isAndroid){
        platform="android";
      }
      if(Platform.isIOS){
        platform="ios";
      }
      await HttpToken().pushToken(platform, apnsToken);
    }
  }


}