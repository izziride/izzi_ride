import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:temp/models/chat/chat_info.dart';
import 'package:temp/pages/main/tabs/chat/chat_item.dart';
import 'package:temp/pages/main/tabs/chat/chat_page.dart';
import 'package:temp/pages/main/tabs/emptyState/empty_state.dart';
import 'package:temp/repository/chats_repo/chats_repo.dart';
import 'package:temp/repository/user_repo/user_repo.dart';
import 'package:temp/socket/socket.dart';

class Chat extends StatefulWidget{
  Chat({super.key});

  final wsUrl = Uri.parse('ws://localhost:1234');
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  

  @override
  void initState() {
    if(userRepository.isAuth){
          chatsRepository.getChats();
           
    }
  
    
  
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    bool auth = userRepository.isAuth;

    return auth?  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20,bottom: 14,left: 15 ),
              child: Text(
                "Messages",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w700,
                  fontSize: 24
                ),
                ),
            ),
           Expanded(
             child:Observer(
               builder: (context) {
                List<ChatInfo> listChats=[];
                chatsRepository.chats.forEach((key, value) { 
                  listChats.add(value);
                });
                 return ListView.builder(
                  itemCount: listChats.length,
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: () {
                        appSocket.fullReadMessage(listChats[index].chatId);
                        chatsRepository.getMessageInchats(listChats[index].chatId, listChats[index].messages[0].id);
                        chatsRepository.updateCurrentChatId(listChats[index].chatId);
                        chatsRepository.updateUnreadInCHat(listChats[index].chatId);
                         Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MessagePage(chatId: listChats[index].chatId),)
                            );
                      },
                      child: ChatItem(
                          chatState:listChats[index]
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