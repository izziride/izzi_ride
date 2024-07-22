
import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:temp/app_information/app_information.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/http/token/http_token.dart';
import 'package:temp/localStorage/tokenStorage/token_storage.dart';
import 'package:temp/localStorage/welcome/welcome.dart';
import 'package:temp/repository/user_repo/user_repo.dart';
import 'package:url_launcher/url_launcher.dart';

class Loader extends StatefulWidget{
  const Loader({super.key});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {

double _progressValue=0.0;

  nextStep(){
    setState(() {
      _progressValue+=0.1;
    });
  }
  fullStep(){
    if(mounted){
      setState(() {
        _progressValue=1.0;
      });
    }
    
  }

  




  initializeService(BuildContext context)async{
    nextStep();
    //check app version
    await appInformation.getAppVersion();
    nextStep();
    await Future.delayed(Duration(seconds: 2));
    nextStep();
    await auth(context);
    fullStep();
  
  
  }

  Future<void> auth(context)async{
    String result =await HttpToken().refreshToken();
    inspect(result);
    if(result=="version_conflict"){
      await showCupertinoDialog(
      context: context, 
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Update require"),
          content: Text("we have launcher a new and improved app. Please update to continue ussing the app."),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("Update now"),
              onPressed: ()async {
                 Uri  url =Uri.parse('https://apps.apple.com/us/app/izzi-ride/id6449208978') ; // Замените на свою ссылку в App Store
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }

          },
            )
          ],
        );
      },
      );
      return;
    }
    if(result=="noAuth"){
      userRepository.isAuth=false;
      await FirstWelcome().clearSharedPreferences();
      int result = await FirstWelcome().getWelocme();
      if(result==0){
        print("goOnboard");
        Navigator.pushNamedAndRemoveUntil(context, "/onboard", (route) => false);
      }else{
        print("goReg");
        Navigator.pushNamedAndRemoveUntil(context, "/reg", (route) => false);
      }
      
    }else{
      userRepository.isAuth=true;
      Navigator.pushNamedAndRemoveUntil(context, "/menu", (route) => false);
    }
    
  }

@override
  void initState() {
    FirstWelcome().setWelcome();
    initializeService(context);
    super.initState();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
        bottomOpacity: 0,
        elevation: 0,
        
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset("assets/image/loader.png"),
          SizedBox(height: 80,),
          Text(
            "Welcome to iZZi Ride!",
            style: TextStyle(
              color: brandBlack,
              fontFamily: "SF",
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16,),
          Text(
            "Find a ride. Give a ride. Easy ride.",
            style: TextStyle(
              color: Color.fromRGBO(177, 178, 179, 1),
              fontFamily: "SF",
              fontSize: 18,
              fontWeight: FontWeight.w400
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 68.75,
              left: 38,
              right: 38,
              top: 108.75
            ),
            child: Container(
              width: double.infinity,
              height: 10.5,
              decoration: BoxDecoration(
                color: Color.fromRGBO(58, 121, 215, 0.24),
                borderRadius: BorderRadius.circular(7)
              ),
              child: Stack(
                children: [
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: _progressValue,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Color.fromRGBO(58, 121, 215, 1)
                      ),
                    ),
                  )
                ],
              ),
            )
          )
        ],
      )
    );
  }
}