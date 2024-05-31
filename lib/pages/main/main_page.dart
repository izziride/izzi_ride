import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/firebase/firebase.dart';
import 'package:temp/localStorage/rate_modal/rate_modal.dart';
import 'package:temp/pages/main/tabs/chat/chat.dart';
import 'package:temp/pages/main/tabs/create/create.dart';
import 'package:temp/pages/main/tabs/my_roads/my_roads.dart';
import 'package:temp/pages/main/tabs/profile/profile.dart';
import 'package:temp/pages/main/tabs/search/search.dart';
import 'package:temp/repository/chats_repo/chats_repo.dart';
import 'package:temp/repository/user_repo/user_repo.dart';
import 'package:temp/socket/socket.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatefulWidget {
  const MainPage({ super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  FirebaseDriver firebaseDriver=FirebaseDriver();
int _indexTab=0;

  int viewConterHomePage=0;

  getUserInfo() async {
    userRepository.getUserInfo();
  }


 updateCountMessage(){
    setState(() {
      
    });
  }

  checkRate()async{
    String result=await RateModalStorage().getRate();
    if(result=="+") viewConterHomePage=2;
  }


  startRateDialog()async{
    

    RateMyApp rateMyApp = RateMyApp(
      preferencesPrefix: 'rateMyApp_',
      minDays: 0,
      minLaunches: 0,
      remindDays: 1,
      remindLaunches: 1,
      googlePlayIdentifier: 'com.easyride.ezride',
      appStoreIdentifier: '1491556149',
    );
    await rateMyApp.init();
rateMyApp.showStarRateDialog(
      context,
      title: 'Rate this app', // The dialog title.
      message: 'You like this app ? Then take a little bit of your time to leave a rating :', // The dialog message.
      // contentBuilder: (context, defaultContent) => content, // This one allows you to change the default dialog content.
      actionsBuilder: (context, stars) { // Triggered when the user updates the star rating.
        return [ // Return a list of actions (that will be shown at the bottom of the dialog).
          GestureDetector(
            onTap: ()async {
              RateModalStorage().setRate();
              launch('https://apps.apple.com/us/app/izzi-ride/id6449208978');
              print('Thanks for the ' + (stars == null ? '0' : stars.round().toString()) + ' star(s) !');
              // You can handle the result as you want (for instance if the user puts 1 star then open your contact page, if he puts more then open the store page, etc...).
              // This allows to mimic the behavior of the default "Rate" button. See "Advanced > Broadcasting events" for more information :
              await rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
              Navigator.pop<RateMyAppDialogButton>(context, RateMyAppDialogButton.rate);
            
            },
            child: Text('OK'),
            
          ),
        ];
      },
      ignoreNativeDialog: Platform.isAndroid, // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
      dialogStyle: const DialogStyle( // Custom dialog styles.
        titleAlign: TextAlign.center,
        messageAlign: TextAlign.center,
        messagePadding: EdgeInsets.only(bottom: 20),
      ),
      starRatingOptions: const StarRatingOptions(), // Custom star bar rating options.
      onDismissed: () => rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
    );
}

  @override
  void initState() {
    checkRate();
    if(userRepository.isAuth){
        userRepository.getUserInfo();
        appSocket.connect();
        firebaseDriver.init();
    }
     
      super.initState();
    }
   
     
 

  @override
  Widget build(BuildContext context) {
    if(viewConterHomePage==1){
      Future.delayed(Duration(milliseconds: 500)).then((value) => startRateDialog(),);
    }
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          toolbarHeight: 0,
          backgroundColor: Colors.white,
          toolbarOpacity: 0,
          elevation: 0,
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          clipBehavior: Clip.none,
          children: [
             const Search(),
             const MyRoads(),
            const CreateTab(),
            Chat(), 
            const Profile()
            ],
        ),
        
        bottomNavigationBar: Container(
          height: 72,
          alignment: Alignment.topCenter,
          decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color: Colors.white, width: 1))),
          child:  TabBar(
            onTap: (value) {
              setState(() {
                if(_indexTab!=0&&value==0){
                  viewConterHomePage=viewConterHomePage+1;
                }
                _indexTab=value;
              });
            },
            padding: EdgeInsets.all(0),
            labelColor: Color.fromRGBO(58, 121, 215, 1),
            unselectedLabelColor: brandGrey,
            indicator: BoxDecoration(
              
            ),
            labelStyle: TextStyle(
              color: brandGrey,
              fontFamily: "Inter",
              fontSize: 12,
              fontWeight: FontWeight.w500,
              
              ),
             labelPadding: EdgeInsets.only(bottom: 17,top: 0),
            indicatorPadding: EdgeInsets.zero,
            tabs: [

              Tab(
                  icon:  SvgPicture.asset("assets/svg/searchTab.svg",color: _indexTab==0?brandBlue:brandGrey,),
                  iconMargin: EdgeInsets.only(bottom: 0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 24,
                    child: Text("Search",)
                    ),
                  
                  
                ),
              Tab( 
                icon: SvgPicture.asset("assets/svg/roadsTab.svg",color: _indexTab==1?brandBlue:brandGrey),
                iconMargin: EdgeInsets.only(bottom: 0),
                child: Container(
                    alignment: Alignment.center,
                    height: 24,
                    child: Text("My trips",)
                    ),
                ),
              Tab( 
                icon: SvgPicture.asset("assets/svg/createTab.svg",
                color: _indexTab==2?brandBlue:brandGrey),
                iconMargin: EdgeInsets.only(bottom: 0),
                child: Container(
                    alignment: Alignment.center,
                    height: 24,
                    child: Text("Create",)
                    ),
                
                ),
              Tab( 
                icon: Observer(
                  builder: (context) {
                    int newMessagesCount=0;
                    chatsRepository.chats.forEach((key, value) {
                      if(value.unreadMsgs>0){
                        newMessagesCount++;
                      }
                    },);

                    return Stack(
                      children: [
                        
                        SvgPicture.asset(
                          "assets/svg/messageTab.svg",
                          color: _indexTab==3?brandBlue:brandGrey
                          ),
                          newMessagesCount>0? Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            alignment: Alignment.center,
                            height: 14,
                            constraints: BoxConstraints(
                              minWidth: 14
                            ),
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Text(
                              newMessagesCount.toString(),
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                height: 1,
                                color: Colors.white,
                                fontFamily: "SF",
                                fontWeight: FontWeight.w600,
                                fontSize: 10
                              ),
                            ),
                          )
                          ):SizedBox.shrink(),
                      ],
                    );
                  }
                ),
                iconMargin: EdgeInsets.only(bottom: 0),
                child: Container(
                    alignment: Alignment.center,
                    height: 24,
                    child: Text("Messages",)
                    ),
                ),
              Tab( 
                icon: SvgPicture.asset("assets/svg/profileTab.svg",
                color: _indexTab==4?brandBlue:brandGrey),
                iconMargin: EdgeInsets.only(bottom: 0),
                child: Container(
                    alignment: Alignment.center,
                    height: 24,
                    child: Text("Profile",)
                    ),
                )
            ],
          ),
        ),
      ),
    );
  }
}