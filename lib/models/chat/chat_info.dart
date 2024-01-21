import 'package:temp/models/chat/chat_members.dart';
import 'package:temp/models/chat/message.dart';

class ChatInfo{
  List<Message> messages;
  List<ChatMembers> chatMembers;
  int unreadMsgs;
  String createdAt;
  String start;
  String end;
  int chatId;
  int orderId;
  Message message;
  ChatInfo({
    required this.end,
    required this.start,
    required this.messages,
    required this.chatId,
    required this.chatMembers,
    required this.orderId,
    required this.unreadMsgs,
    required this.createdAt,
    required this.message
  });
}
