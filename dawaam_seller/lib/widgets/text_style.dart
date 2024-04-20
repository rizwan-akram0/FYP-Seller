import 'package:dawaam_seller/consts/consts.dart';

Widget normalText({text, color = Colors.white, size = 14.0}) {
  return Text(
    "$text",
    style: TextStyle(
      color: color,
      fontSize: size,
      fontFamily: regular,
    ),
  );
}

Widget boldText({text, color = Colors.white, size = 14.0}) {
  return Text(
    "$text",
    style: TextStyle(
      color: color,
      fontSize: size,
      fontFamily: bold,
    ),
  );
}
