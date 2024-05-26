class Chat {
  String senderId;
  String recipientId;
  String text;
  String? status;

  Chat({
    required this.senderId,
    required this.recipientId,
    required this.text,
    this.status,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        senderId: json["senderId"],
        recipientId: json["recipientId"],
        text: json["text"],
        status: json["status"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "senderId": senderId,
        "recipientId": recipientId,
        "text": text,
        "status": status,
      };
}
