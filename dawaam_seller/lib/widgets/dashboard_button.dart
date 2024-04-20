import 'package:dawaam_seller/consts/consts.dart';
import 'package:dawaam_seller/widgets/text_style.dart';

Widget dashboardButton(context, {title, count, icon}) {
  var size = MediaQuery.of(context).size;
  return Container(
    padding: const EdgeInsets.all(8.0),
    width: size.width,
    height: 120,
    decoration: BoxDecoration(
      color: kSecondaryLightColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boldText(text: "   $title", size: 22.0),
              Center(child: boldText(text: "$count", size: 32.0))
            ],
          ),
        ),
        Image.asset(
          icon,
          width: 50,
          color: whiteColor,
        ),
        const SizedBox(width: 20),
      ],
    ),
  );
}
