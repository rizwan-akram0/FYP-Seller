import 'dart:developer';

import 'package:dawaam_seller/consts/consts.dart';
import 'package:dawaam_seller/controllers/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shimmer_pro/shimmer_pro.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController ordersController = Get.put(OrderController());

    ordersController.fetchOrdersBySellerId();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orders',
          style: TextStyle(
            color: kPrimaryLightColor,
            fontFamily: medium,
            fontSize: 16,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Obx(
          () {
            if (ordersController.orders.isEmpty) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      // leading: ShimmerPro.sized(
                      //     scaffoldBackgroundColor: lightGrey,
                      //     height: 50,
                      //     width: 60),
                      title: ShimmerPro.sized(
                          scaffoldBackgroundColor: lightGrey,
                          height: 20,
                          width: MediaQuery.of(context).size.width * 0.6),
                      subtitle: ShimmerPro.sized(
                          scaffoldBackgroundColor: lightGrey,
                          height: 20,
                          width: MediaQuery.of(context).size.width * 0.6),
                      trailing: IconButton(
                        icon: const Icon(Icons.more_vert_outlined),
                        onPressed: () {
                          // Get.to(() => const EditProductScreen(),
                          //     transition: Transition.rightToLeftWithFade);
                        },
                      ),
                    ),
                  );
                },
              );
            } else {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: ordersController.orders.length,
                itemBuilder: (context, index) {
                  final order = ordersController.orders[index];
                  final time = intl.DateFormat('yyyy-MM-dd hh:mm')
                      .format(order.createdAt.toLocal());
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Get.to(
                          () => OrderDetailScreen(order: order),
                          transition: Transition.rightToLeftWithFade,
                        );
                      },
                      leading: Image.asset(
                        icOrders,
                        width: 40,
                      ),
                      title: Text('Order ID: ${order.orderId}'),
                      subtitle: Text(time.toString()),
                      // Add more UI elements as needed
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
