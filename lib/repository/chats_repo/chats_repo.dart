import 'package:mobx/mobx.dart';
import 'package:temp/http/chats/http_chats.dart';
import 'package:temp/http/user/http_user.dart';
import 'package:temp/models/chat/chat_info.dart';
import 'package:temp/models/chat/message.dart';
import 'package:temp/repository/user_repo/user_repo.dart';
import 'package:temp/socket/socket.dart';

part 'chats_repo.g.dart';


class ChatsRepo = _ChatsRepo with _$ChatsRepo;

abstract class _ChatsRepo with Store  {
 
  @observable
  ObservableMap<String,ChatInfo> chats=ObservableMap();
 
  @observable
  int currentChatId=-1;

  @action
  void updateCurrentChatId(int updateValue){
    currentChatId=updateValue;
  }

  @action
  Future<void> getChats()async{
    final result =await HttpChats().getUserChats();
        result.forEach((element) { 
          chats[element.chatId.toString()]=element;
        });
        if(currentChatId!=-1){
            appSocket.fullReadMessage(currentChatId);
        }
        if(currentChatId!=-1 && chats[currentChatId.toString()]!.messages.isNotEmpty){

          getMessageInchats(currentChatId, chats[currentChatId.toString()]!.messages[0].id);
        }
        chats=ObservableMap.of(chats);
  }

  @action
  Future<void> getChat(int chatId)async{
    final result =await HttpChats().getUserChat(chatId);
    if(result!=null){
      chats[chatId.toString()]=result;
    }
    chats=ObservableMap.of(chats);
        
  }

  Future<int> checkChatIsNotEmpty(int chatId)async{
    try {
      if(chats[chatId.toString()]==null){
      final result = await HttpChats().getUserChat(chatId);
       if(result!=null){
      chats[chatId.toString()]=result;
      }
      chats=ObservableMap.of(chats);
    }
    return 0;
    } catch (e) {
      return -1;
    }
    
   
  }

  @action
 Future<void> addMessage(Message message)async{ 
    if(chats[message.chatId.toString()]!=null){
       chats[message.chatId.toString()]!.messages.insert(0,
       message
      );
      
    }else{
      int code=await checkChatIsNotEmpty(message.chatId);
      if(code==0){

        chats[message.chatId.toString()]!.messages.insert(0,
        message
        );
       
        
      }
    }
     if(message.chatId!=currentChatId){
          chats[message.chatId.toString()]!.unreadMsgs=chats[message.chatId.toString()]!.unreadMsgs+1;
        }
    print(currentChatId);
    print(message.chatId);
    if(currentChatId==message.chatId){
          appSocket.fullReadMessage(message.chatId);
        }
    chats = ObservableMap.of(chats);
  }
  
  @action
  editStatus(String chatId,int status,String frontContentId,String time,){
    if(chats[chatId]!=null){
      int index = chats[chatId]!.messages.indexWhere((element) =>element.frontContentId==frontContentId);
      if(index!=-1){
         chats[chatId]!.messages[index].status=status;
          chats[chatId]!.messages[index].time=time;
         chats = ObservableMap.of(chats);
      }
     

    }
  }
  @action
  Future<void> getMessageInchats(int chatId,int messageId)async{
    if(chats[chatId.toString()]!=null && chats[chatId.toString()]!.messages.length>10){
      return;
    }
     final messages = await HttpChats().getChatMessage(chatId, messageId);
     if(messages.isNotEmpty && chats[chatId.toString()]!=null){

      if(chats[chatId.toString()]!.messages.isEmpty){
          chats[chatId.toString()]!.messages=messages;
          
      }else{
        for (var element in messages) { 
           chats[chatId.toString()]!.messages=messages;
          }
      }
      
       chats=ObservableMap.of(chats);
     }
  }

  @action
  fullRead(String chatId){
    if(chats[chatId]!=null){
       List<Message> messages=chats[chatId]!.messages;
       messages.forEach((element) { 
        if(element.senderClientId==userRepository.userInfo.clienId){
             element.status=1;
        }
       
       });
       chats[chatId]!.messages=messages;
       chats = ObservableMap.of(chats);
    }
   
  }

  @action
  updateUnreadInCHat(int chatId){
    if(chats[chatId.toString()]!=null){
      chats[chatId.toString()]!.unreadMsgs=0;
      chats=ObservableMap.of(chats);
    }
  }
   @action
  deleteChat(int chatId){
    if(chats[chatId.toString()]!=null){
      chats.removeWhere((key, value) => value.chatId==chatId);
      chats=ObservableMap.of(chats);
    }
  }
} 


ChatsRepo chatsRepository=ChatsRepo();