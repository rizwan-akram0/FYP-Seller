import 'dart:developer';

import 'package:dawaam_seller/consts/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class URLServices {
  final productController = Get.put(ProductController());
  final authController = Get.put(AuthController());
  static String baseUrl = 'http://192.168.100.120:8080';
  static String webSocketUrl = 'ws://192.168.100.120:8080';

  final prefs = SharedPreferences.getInstance().then((value) {
    baseUrl = 'http://${value.getString('baseUrl')}';
    webSocketUrl = 'ws://${value.getString('baseUrl')}';
  });

  setURL() {
    final prefs = SharedPreferences.getInstance().then((value) {
      baseUrl = 'http://${value.getString('baseUrl')}';
      log(value.getString('baseUrl') ?? '');
      webSocketUrl = 'ws://${value.getString('baseUrl')}';
      // baseUrl = 'http://192.168.0.124:8080';
      // webSocketUrl = 'ws://192.168.0.124:8080';
    });
    authController.getProfileDetails();
    productController.getTotalOrders();
    productController.getTotalProducts();

    print('Base URL: $baseUrl');
    print('Web Socket URL: $webSocketUrl');
  }
}
