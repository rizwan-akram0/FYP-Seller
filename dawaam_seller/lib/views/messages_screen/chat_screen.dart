import 'package:dawaam_seller/consts/consts.dart';
import 'package:dawaam_seller/models/chat_model.dart';
import 'package:dawaam_seller/views/messages_screen/reciever_bubble.dart';
import 'package:dawaam_seller/views/messages_screen/sender_bubble.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:web_socket_channel/io.dart';

class ChatScreen extends StatefulWidget {
  final String senderId;
  final String recipientId;

  const ChatScreen(
      {Key? key, required this.senderId, required this.recipientId})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IOWebSocketChannel _channel;
  final TextEditingController _messageController = TextEditingController();
  final List<Chat> _messages = [];

  @override
  void initState() {
    log('Sender: ${widget.senderId}');
    log('Recipient: ${widget.recipientId}');
    super.initState();
    _channel = IOWebSocketChannel.connect(
        'ws://192.168.100.7:5000/${widget.senderId}/${widget.recipientId}');

    _channel.stream.listen((message) {
      final Map<String, dynamic> data = jsonDecode(message);
      final chat = Chat.fromJson(data);
      setState(() {
        log('Received message: $message');
        _messages.insert(0, chat);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final chat = _messages[index];
                return chat.senderId == widget.senderId
                    ? SenderBubble(message: chat.text)
                    : ReceiverBubble(message: chat.text);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _messageController,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: greyColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: kSecondaryLightColor),
                      ),
                      hintText: "Type a message...",
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    final message = {
                      'senderId': widget.senderId,
                      'recipientId': widget.recipientId,
                      'text': _messageController.text,
                    };
                    _messages.insert(0, Chat.fromJson(message));
                    setState(() {});
                    _channel.sink.add(jsonEncode(message));
                    _messageController.clear();
                  },
                  icon: const Icon(
                    Icons.send,
                    color: kSecondaryLightColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
