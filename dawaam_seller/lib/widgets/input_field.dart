
import 'package:dawaam_seller/consts/consts.dart';

// ignore: non_constant_identifier_names
Widget InputField({
  required String hint,
  required String label,
  required keyboardType,
  required textCapitalization,
  required controller,
  autofocus = false,
}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: medium,
                fontSize: 14,
                color: kPrimaryLightColor,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              '*',
              style: TextStyle(
                fontFamily: medium,
                fontSize: 14,
                color: redColor,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      TextFormField(
        controller: controller,
        autofocus: autofocus,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        cursorColor: kSecondaryLightColor,
        style: const TextStyle(
          fontFamily: pRegular,
          fontSize: 14,
          color: kPrimaryLightColor,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: pRegular,
            fontSize: 14,
            color: greyColor,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: lightGrey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: kSecondaryLightColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: redColor,
            ),
          ),
        ),
      ),
    ],
  );
}
