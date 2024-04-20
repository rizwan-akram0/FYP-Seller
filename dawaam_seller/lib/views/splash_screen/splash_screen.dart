import 'package:dawaam_seller/consts/consts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authController = Get.put(AuthController());
  _checkLogin() async {
    Timer(
      const Duration(seconds: 3),
      () {
        if (authController.userId.value.toString() != '' &&
            authController.userId.value.toString() != 'null') {
          Get.offAll(() => const Home(), transition: Transition.rightToLeft);
        } else {
          Get.offAll(() => const LoginScreen(),
              transition: Transition.rightToLeft);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          logo,
          width: 300,
        ),
      ),
    );
  }
}
