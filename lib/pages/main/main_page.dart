import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/pages/main/tabs/chat/chat.dart';
import 'package:temp/pages/main/tabs/create/create.dart';
import 'package:temp/pages/main/tabs/my_roads/my_roads.dart';
import 'package:temp/pages/main/tabs/profile/profile.dart';
import 'package:temp/pages/main/tabs/search/search.dart';
import 'package:temp/repository/chats_repo/chats_repo.dart';
import 'package:temp/repository/user_repo/user_repo.dart';
import 'package:temp/socket/socket.dart';

class MainPage extends StatefulWidget {
  const MainPage({ super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

int _indexTab=0;

  getUserInfo() async {
    userRepository.getUserInfo();
  }


 updateCountMessage(){
    setState(() {
      
    });
  }

  @override
  void initState() {
    if(userRepository.isAuth){
        userRepository.getUserInfo();
        appSocket.connect();
    }
     
      super.initState();
    }
   
     
 

  @override
  Widget build(BuildContext context) {
    
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