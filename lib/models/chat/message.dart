class Message{
  int id;
  int senderClientId;
  int chatId;
  String frontContentId;
  String type;
  String content;
  String time;
  int status;
  Message({
    required this.chatId,
    required this.content,
    required this.frontContentId,
    required this.id,
    required this.senderClientId,
    required this.time,
    required this.type,
    required this.status
  });

  toMap(){
    return {
      "uuid":frontContentId,
      "text":content,
      "status":status,
      "chatId":chatId,
      "date":time
    };
  }
}