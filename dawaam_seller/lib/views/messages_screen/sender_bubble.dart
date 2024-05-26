import 'package:dawaam_seller/consts/consts.dart';

class SenderBubble extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final message;
  const SenderBubble({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: kSecondaryLightColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Text(
          message,
          style: const TextStyle(
              color: Colors.white, fontFamily: pRegular, letterSpacing: 1),
        ),
      ),
    );
  }
}
