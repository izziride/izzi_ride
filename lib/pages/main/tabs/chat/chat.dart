import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/http/chats/http_chats.dart';
import 'package:temp/models/chat/chat_info.dart';
import 'package:temp/pages/main/tabs/chat/chat_empty_widget.dart';
import 'package:temp/pages/main/tabs/chat/chat_item.dart';
import 'package:temp/pages/main/tabs/chat/chat_page.dart';
import 'package:temp/pages/main/tabs/emptyState/empty_state.dart';
import 'package:temp/repository/chats_repo/chats_repo.dart';
import 'package:temp/repository/user_repo/user_repo.dart';
import 'package:temp/socket/socket.dart';

class Chat extends StatefulWidget{
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> with TickerProviderStateMixin  {

  late AnimationController _opacityController; 
  late AnimationController _heightController; 
  late Animation<double> _opacityAnimation;
  late Animation<double> _heihtAnimation;

  @override
  void initState() {
    
    
    _opacityController= AnimationController(
      duration: const Duration(milliseconds: 200), 
      vsync: this,
      reverseDuration: Duration.zero,
      
    );
    _heightController= AnimationController(
      duration: const Duration(milliseconds: 200), 
      vsync: this,
      reverseDuration: Duration.zero
    );
    _opacityAnimation = Tween<double>(
      begin: 1.0, 
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _opacityController,
        curve: Curves.easeIn, // Задаем тип анимации
      ),
    );
    _heihtAnimation = Tween<double>(
      begin: 0.0, 
      end: 1.0, 
    ).animate(
      CurvedAnimation(
        parent: _heightController,
        curve: Curves.easeIn, // Задаем тип анимации
      ),
    );
    if(userRepository.isAuth){
          chatsRepository.getChats();   
    }
    super.initState();
  }

  bool contextMenu=false;
  List<int> variableChatId=[];


  @override
  Widget build(BuildContext context) {

    bool auth = userRepository.isAuth;

    return auth?  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AnimatedBuilder(
                  animation: _opacityAnimation,
                  builder: (context,child) {
                    return Opacity(
                      opacity: _opacityAnimation.value,
                      child: SizedBox(
                        height: 70,
                        child: const Padding(
                          padding: EdgeInsets.only(top: 20,left: 15 ),
                          child: Text(
                            "Messages",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w700,
                              fontSize: 24
                            ),
                            ),
                        ),
                      ),
                    );
                  }
                ),
                AnimatedBuilder(
                  animation: _heihtAnimation,
                  builder: (context,child) {
                    return Opacity(
                opacity: _heihtAnimation.value,
                 child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: brandBlue,
                        width: 2
                      )
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 20,),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                variableChatId=[];
                                contextMenu=false;
                                _opacityController.reverse();
                                _heightController.reverse();
                              });
                            },
                            child: Icon(Icons.close, size: 30,color: brandBlue,)
                            ),
                        ],
                      ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  variableChatId=[];
                                  contextMenu=false;
                                });
                              },
                              child: Icon(Icons.done, size: 30,color: brandBlue,)
                              ),
                               SizedBox(width: 20,),
                              GestureDetector(
                              onTap: () async{
                                for(int chatId in variableChatId ){
                                 int code= await HttpChats().deleteChat(chatId);
                                 if(code==0){
                                  chatsRepository.deleteChat(chatId);
                                 }
                                }
                                setState(() {
                                  variableChatId=[];
                                  contextMenu=false;
                                });
                              },
                              child: Icon(Icons.delete_forever, size: 30,color: brandBlue,)
                              ),
                               SizedBox(width: 20,),
                          ],
                        )
                    ],
                  ),
                 ),
               );
                  }
                ),
              ],
            ),

           Expanded(
             child:Observer(
               builder: (context) {
                List<ChatInfo> listChats=[];
                chatsRepository.chats.forEach((key, value) { 
                  listChats.add(value);
                });
                if(listChats.isEmpty){
                  return MessagesEmptyState();
                }
                 return ListView.builder(
                  itemCount: listChats.length,
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: () {
                        if(contextMenu){
                          setState(() {
                            bool find=false;
                            for(int chatId in variableChatId){
                              if(chatId==listChats[index].chatId){
                                find=true;
                                break;
                              }
                            }
                            if(find){
                              variableChatId=variableChatId.where((element) => element!=listChats[index].chatId).toList();
                            }else{
                              variableChatId.add(listChats[index].chatId);
                            }
                           
                          });
                        }else{
                          appSocket.fullReadMessage(listChats[index].chatId);
                        chatsRepository.getMessageInchats(listChats[index].chatId, listChats[index].messages[0].id);
                        chatsRepository.updateCurrentChatId(listChats[index].chatId);
                        chatsRepository.updateUnreadInCHat(listChats[index].chatId);
                         Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MessagePage(chatId: listChats[index].chatId),)
                            );
                        }
                        
                      },
                      onLongPress: () {
                          setState(() {
                            contextMenu=true;
                            variableChatId.add(listChats[index].chatId);
                          });
                          _opacityController.forward();
                           _heightController.forward();
                        },
                      child: ChatItem(
                          chatState:listChats[index],
                          variableChatId:variableChatId,
                          contextMenu:contextMenu,
                      ),
                    );
                  },
                  );
               }
             )
           )
          ],
      
    )
    :EmptyStateAllPAge();
  }
}