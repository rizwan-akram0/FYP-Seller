import 'package:dawaam_seller/consts/consts.dart';

class ReceiverBubble extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final message;
  const ReceiverBubble({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Text(
          message,
          style: const TextStyle(
              color: Colors.black, fontFamily: pRegular, letterSpacing: 1),
        ),
      ),
    );
  }
}
