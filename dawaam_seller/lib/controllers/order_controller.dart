import 'dart:convert';
import 'dart:developer';

import 'package:dawaam_seller/consts/consts.dart';
import 'package:dawaam_seller/models/orders_model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderController extends GetxController {
  final RxList<OrderElement> orders = <OrderElement>[].obs;
  final orderDetailLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrdersBySellerId(); // Fetch orders when controller initializes
  }

  Future<void> fetchOrdersBySellerId() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String sellerId = prefs.getString('userId') ?? '';
      print('Seller ID: $sellerId');
      final String apiUrl =
          '${URLServices.baseUrl}/order/orders_by_seller/$sellerId';

      final response = await http.get(Uri.parse(apiUrl));

      // log('Response: ${response.body}');

      if (response.statusCode == 200) {
        final List<OrderElement> orderList = List<OrderElement>.from(json
            .decode(response.body)['orders']
            .map((x) => OrderElement.fromJson(x)));

        orders.assignAll(orderList); // Update RxList with fetched orders
        print('Orders: ${orders.length}');
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      print('Error: $e');
      // Handle error state or show a snack bar
    }
  }

  Future confirmOrder(String orderId) async {
    try {
      final String apiUrl =
          '${URLServices.baseUrl}/order/confirm_order/$orderId';
      final response = await http.put(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        log('Order confirmed');
        fetchOrdersBySellerId();
      } else {
        throw Exception('Failed to confirm order');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  cancelOrder(String orderId) async {
    try {
      final String apiUrl =
          '${URLServices.baseUrl}/order/cancel_order/$orderId';
      final response = await http.put(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        log('Order cancelled');
        fetchOrdersBySellerId();
      } else {
        throw Exception('Failed to cancel order');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  deliverOrder(String orderId) async {
    try {
      final String apiUrl =
          '${URLServices.baseUrl}/order/deliver_order/$orderId';
      final response = await http.put(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        log('Order delivered');
        fetchOrdersBySellerId();
      } else {
        throw Exception('Failed to deliver order');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  dispatchOrder(String orderId) async {
    try {
      final String apiUrl =
          '${URLServices.baseUrl}/order/dispatch_order/$orderId';
      final response = await http.put(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        log('Order dispatched');
        fetchOrdersBySellerId();
      } else {
        throw Exception('Failed to dispatch order');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<OrderElement> getOrderById(String orderId) async {
    try {
      orderDetailLoading.value = true;
      final String apiUrl =
          '${URLServices.baseUrl}/order/get_order_by_id/$orderId';
      final response = await http.get(Uri.parse(apiUrl));

      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody.containsKey('order')) {
          final OrderElement order =
              OrderElement.fromJson(responseBody['order']);
          return order;
        } else {
          throw Exception('Order not found in response');
        }
      } else {
        throw Exception('Failed to load order');
      }
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception('Failed to load order');
    } finally {
      orderDetailLoading.value = false;
    }
  }
}
