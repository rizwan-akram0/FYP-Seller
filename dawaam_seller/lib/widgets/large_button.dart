import 'package:dawaam_seller/consts/consts.dart';

// ignore: non_constant_identifier_names
Widget LargeButton({onPress, String title = "", color = kPrimaryLightColor}) =>
    ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        elevation: 10,
        backgroundColor: color,
        splashFactory: InkSplash.splashFactory,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        minimumSize: const Size(double.infinity, 60),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: semibold,
          fontSize: 16,
          color: whiteColor,
        ),
      ),
    );
