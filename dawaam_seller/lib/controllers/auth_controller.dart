import 'dart:developer';

import 'package:dawaam_seller/consts/consts.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();

  final userId = ''.obs;
  final email = ''.obs;
  final name = ''.obs;
  final phone = ''.obs;
  final image = ''.obs;
  final address = ''.obs;

  @override
  void onInit() {
    getProfileDetails();
    super.onInit();
  }

  login() async {
    try {
      final body = {
        'email': emailController.text.toLowerCase().trim(),
        'password': passwordController.text,
      };

      final response = await http.post(
        Uri.parse('$baseUrl/seller/login'),
        body: body,
      );

      if (response.statusCode == 200) {
        log(response.body);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userId', json.decode(response.body)['id'] ?? '');
        prefs.setString('email', json.decode(response.body)['email'] ?? '');
        prefs.setString('name', json.decode(response.body)['name'] ?? '');
        prefs.setString('phone', json.decode(response.body)['phone'] ?? '');
        prefs.setString('image', json.decode(response.body)['image'] ?? '');
        prefs.setString('address', json.decode(response.body)['address'] ?? '');

        emailController.clear();
        passwordController.clear();
        getProfileDetails();
        Get.offAll(() => const Home(), transition: Transition.rightToLeft);
      } else {
        Get.snackbar('Error', json.decode(response.body)['message']);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  getProfileDetails() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userId.value = prefs.getString('userId').toString();
      email.value = prefs.getString('email').toString();
      name.value = prefs.getString('name').toString();
      phone.value = prefs.getString('phone').toString();
      image.value = prefs.getString('image').toString();
      address.value = prefs.getString('address').toString();
      nameController.text = prefs.getString('name') ?? '';

      log(userId.value);
      log(email.value);
      log(name.value);
      log(phone.value);
      log(image.value);
      log(address.value);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.clear();
      userId.value = '';
      email.value = '';
      name.value = '';
      phone.value = '';
      image.value = '';
      address.value = '';

      Get.offAll(() => const LoginScreen(), transition: Transition.rightToLeft);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
