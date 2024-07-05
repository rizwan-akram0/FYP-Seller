import '../../consts/consts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Image.asset(
          logo,
          width: 120,
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Change URL's"),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: controller.urlController,
                            decoration: const InputDecoration(
                              labelText: "URL",
                              hintText: "https://api.dawaamfoods.com",
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          final prefs = SharedPreferences.getInstance();
                          prefs.then((value) {
                            value.setString(
                                "baseUrl", controller.urlController.text);
                          });
                          URLServices().setURL();
                          Navigator.pop(context);
                        },
                        child: const Text("Save"),
                      ),
                    ],
                  ),
                );
              },
              child: const Text(
                'Login',
                style: TextStyle(
                  fontFamily: bold,
                  fontSize: 24,
                  color: kPrimaryLightColor,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Text(
                  'Don’t have an account? ',
                  style: TextStyle(
                    fontFamily: regular,
                    fontSize: 14,
                    color: greyColor,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const SignUpScreen(),
                    //   ),
                    // );
                  },
                  child: const Text(
                    'Contact Admin',
                    style: TextStyle(
                      fontFamily: regular,
                      fontSize: 14,
                      color: kSecondaryLightColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            InputField(
              controller: controller.emailController,
              label: 'Email',
              hint: 'Enter your Email',
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
              autofocus: true,
            ),
            const SizedBox(
              height: 20,
            ),
            PasswordInputField(
              controller: controller.passwordController,
              autofocus: false,
            ),
            const SizedBox(
              height: 15,
            ),
            const Spacer(),
            LargeButton(
              title: 'Login',
              onPress: () {
                controller.login();
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
