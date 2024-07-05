import 'package:dawaam_seller/consts/consts.dart';

Widget backButton(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);
    },
    child: Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: Image.asset(
          icArrow,
          color: kPrimaryLightColor,
          width: 25,
        ),
      ),
    ),
  );
}
