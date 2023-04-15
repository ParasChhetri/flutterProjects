class Message {
  String message;
  String sentMsg;
  Message({required this.message,required this.sentMsg});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(message: json["message"], sentMsg: json["sentMsg"]);
  }
}
