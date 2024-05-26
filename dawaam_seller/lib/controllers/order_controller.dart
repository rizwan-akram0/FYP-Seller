import 'dart:developer';

import 'package:dawaam_seller/consts/consts.dart';
import 'package:dawaam_seller/models/orders_model.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController {
  final RxList<Order> orders = <Order>[].obs;

  

  Stream<List<OrderElement>> fetchOrdersBySellerId() async* {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String sellerId = prefs.getString('userId') ?? '';
      log('Seller ID: $sellerId');
      final String apiUrl =
          '$baseUrl/order/orders_by_seller/$sellerId'; // Replace with your API base URL

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        log(response.body);

        List<OrderElement> orderList = List<OrderElement>.from(json
            .decode(response.body)['orders']
            .map((x) => OrderElement.fromJson(x)));

        log(orderList.toString());

        log('Orders: ${orderList.first.id}');
        yield orderList;
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      log('Error: $e');
    }
  }
}
