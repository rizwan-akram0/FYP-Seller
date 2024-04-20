import 'package:dawaam_seller/consts/consts.dart';

class PasswordInputField extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final hint, label, autofocus, controller;
  const PasswordInputField({
    super.key,
    this.hint = 'Enter your Password',
    this.label = 'Password',
    this.autofocus = false,
    required this.controller,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool obsecure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Row(
            children: [
              Text(
                widget.label,
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
          controller: widget.controller,
          autofocus: widget.autofocus,
          obscureText: obsecure,
          keyboardType: TextInputType.visiblePassword,
          textCapitalization: TextCapitalization.words,
          cursorColor: kSecondaryLightColor,
          style: const TextStyle(
            fontFamily: pRegular,
            fontSize: 14,
            color: kPrimaryLightColor,
          ),
          decoration: InputDecoration(
            suffixIcon: obsecure
                ? IconButton(
                    onPressed: () {
                      obsecure = !obsecure;
                      setState(() {});
                    },
                    icon: Image.asset(icPassHide, width: 20),
                    color: kSecondaryLightColor,
                  )
                : IconButton(
                    onPressed: () {
                      obsecure = !obsecure;
                      setState(() {});
                    },
                    icon: Image.asset(icPassShow, width: 20),
                    color: kSecondaryLightColor,
                  ),
            hintText: widget.hint,
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
}
