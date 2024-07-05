import 'dart:developer';

import 'package:dawaam_seller/consts/consts.dart';
import 'package:dawaam_seller/models/user_model.dart';
import 'package:dawaam_seller/services/notification_services.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final urlController = TextEditingController();

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
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        log('Please fill all fields');
        Get.snackbar('Error', 'Please fill all fields');
        return;
      }
      final productController = Get.put(ProductController());

      final fcm = await NotificationService().getFCMToken();
      final body = {
        'email': emailController.text.toLowerCase().trim(),
        'password': passwordController.text,
        'fcm': fcm,
      };
      log(body.toString());
      log('${URLServices.baseUrl}/seller/login');

      final response = await http.post(
        Uri.parse('${URLServices.baseUrl}/seller/login'),
        body: body,
      );
      log(response.body);

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
        productController.getTotalOrders();
        productController.getTotalProducts();

        Get.offAll(() => const Home(), transition: Transition.rightToLeft);
      } else {
        // Get.snackbar('Error', json.decode(response.body)['message']);
      }
    } catch (e) {
      // Get.snackbar('Error', e.toString());
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
      // Get.snackbar('Error', e.toString());
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
      // Get.snackbar('Error', e.toString());
    }
  }

  Stream<List<User>> getUsers() async* {
    try {
      final response = await http
          .get(Uri.parse('${URLServices.baseUrl}/user/get_all_users'));

      if (response.statusCode == 200) {
        log(response.body);
        final users = usersFromJson(response.body).data.user;
        yield users;
      } else {
        // Get.snackbar('Error', json.decode(response.body)['message']);
      }
    } catch (e) {
      // Get.snackbar('Error', e.toString());
    }
  }
}
