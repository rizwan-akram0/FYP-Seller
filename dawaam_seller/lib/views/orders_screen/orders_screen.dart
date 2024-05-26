import 'dart:developer';

import 'package:dawaam_seller/consts/consts.dart';
import 'package:dawaam_seller/controllers/order_controller.dart';
import 'package:dawaam_seller/models/orders_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersController = Get.put(OrderController());
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
        child: StreamBuilder<List<OrderElement>>(
          stream: ordersController.fetchOrdersBySellerId(),
          builder: (context, snapshot) {
            log('Snapshot: ${snapshot.data}');
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              log('Error: ${snapshot.error}');
              return const Center(child: Text('Error fetching orders'));
            } else if (snapshot.data!.isEmpty) {
              return const Center(child: Text('No orders found'));
            }

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final order = snapshot.data![index];
                final time =
                    intl.DateFormat('yyyy-MM-dd hh:mm').format(order.createdAt);
                return Card(
                  child: ListTile(
                    onTap: () {
                      Get.to(() => OrderDetailScreen(order: order),
                          transition: Transition.rightToLeftWithFade);
                    },
                    leading: Image.asset(
                      icOrders,
                      width: 40,
                    ),
                    title: Text('Order ID: ${order.orderId}'),
                    subtitle: Text(time.toString()),
                    // trailing: IconButton(
                    // icon: const Icon(Icons.more_vert_outlined),
                    // onPressed: () {
                    //   showModalBottomSheet(
                    //     context: context,
                    //     builder: (context) {
                    //       return Column(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           ListTile(
                    //             leading: const Icon(Icons.delete),
                    //             title: const Text('Accept'),
                    //             onTap: () {
                    //               // ordersController.deleteOrder(order.id);
                    //               Get.back();
                    //             },
                    //           ),
                    //           ListTile(
                    //             leading: const Icon(Icons.delete),
                    //             title: const Text('Delete'),
                    //             onTap: () {
                    //               // ordersController.deleteOrder(order.id);
                    //               Get.back();
                    //             },
                    //           ),
                    //         ],
                    //       );
                    //     },
                    //   );
                    // },
                    // ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
