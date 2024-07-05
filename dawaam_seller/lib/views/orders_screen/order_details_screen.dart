import 'package:cached_network_image/cached_network_image.dart';
import 'package:dawaam_seller/consts/consts.dart';
import 'package:dawaam_seller/controllers/order_controller.dart';
import 'package:dawaam_seller/models/orders_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailScreen extends StatefulWidget {
  final OrderElement order;
  const OrderDetailScreen({super.key, required this.order});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final orderController = Get.put(OrderController());
  late Future<OrderElement> futureOrder;

  @override
  void initState() {
    super.initState();
    futureOrder = fetchOrder();
  }

  Future<OrderElement> fetchOrder() async {
    return await orderController.getOrderById(widget.order.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Details',
          style: TextStyle(
            color: kPrimaryLightColor,
            fontFamily: medium,
            fontSize: 16,
          ),
        ),
      ),
      body: FutureBuilder<OrderElement>(
        future: futureOrder,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Order not found'));
          } else {
            final order = snapshot.data!;
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Order ID'),
                      subtitle: Text(order.orderId ?? 'N/A'),
                    ),
                    ListTile(
                      title: const Text('Order Date'),
                      subtitle: Text(order.createdAt != null
                          ? order.createdAt.toLocal().toString()
                          : 'N/A'),
                    ),
                    ListTile(
                      title: const Text('Order Status'),
                      subtitle: Text(order.status ?? 'N/A'),
                    ),
                    ListTile(
                      title: const Text('Total Amount'),
                      subtitle: Text(order.totalAmount != null
                          ? order.totalAmount.toString()
                          : 'N/A'),
                    ),
                    const ListTile(
                      title: Text('Payment Method'),
                      subtitle: Text('Cash on delivery'),
                    ),
                    ListTile(
                      title: const Text('Delivery Address'),
                      subtitle: Text(order.shippingAddress ?? 'N/A'),
                    ),
                    const ListTile(
                      title: Text('Delivery Charges'),
                      subtitle: Text('0 PKR'),
                    ),
                    ListTile(
                      title: const Text('Order Items'),
                      subtitle: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: order.items.length,
                        itemBuilder: (context, index) {
                          final item = order.items[index];
                          return ListTile(
                            leading: CachedNetworkImage(
                              imageUrl: item.productId.images.isNotEmpty
                                  ? '${URLServices.baseUrl}${item.productId.images.first}'
                                  : 'default_image_url',
                              placeholder: (context, url) => const Icon(
                                Icons.image,
                                color: Colors.grey,
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              item.productId.name ?? 'N/A',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              item.productId.description ?? 'N/A',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Text(
                              item.productId.price != null
                                  ? item.productId.price.toString()
                                  : 'N/A',
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    order.status == 'Pending'
                        ? LargeButton(
                            title: 'Confirm Order',
                            onPress: () {
                              orderController.confirmOrder(order.id);
                              Timer(const Duration(seconds: 2), () {
                                setState(() {
                                  futureOrder = fetchOrder();
                                });
                              });
                            },
                          )
                        : order.status == 'Confirmed'
                            ? LargeButton(
                                title: 'Dispatch Order',
                                onPress: () {
                                  orderController.dispatchOrder(order.id);
                                  Timer(const Duration(seconds: 2), () {
                                    setState(() {
                                      futureOrder = fetchOrder();
                                    });
                                  });
                                },
                              )
                            : order.status == 'Dispatched'
                                ? LargeButton(
                                    title: 'Deliver Order',
                                    onPress: () {
                                      orderController.deliverOrder(order.id);
                                      Timer(const Duration(seconds: 2), () {
                                        setState(() {
                                          futureOrder = fetchOrder();
                                        });
                                      });
                                    },
                                  )
                                : order.status == 'Delivered'
                                    ? const Text(
                                        'Order Delivered',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontFamily: medium,
                                          fontSize: 16,
                                        ),
                                      )
                                    : const SizedBox(),
                    const SizedBox(height: 10),
                    order.status != 'Cancelled' && order.status != 'Delivered'
                        ? LargeButton(
                            title: 'Cancel Order',
                            color: Colors.red,
                            onPress: () {
                              orderController.cancelOrder(order.id);
                              Timer(const Duration(seconds: 2), () {
                                setState(() {
                                  futureOrder = fetchOrder();
                                });
                              });
                            },
                          )
                        : const SizedBox(),
                    order.status == 'Cancelled'
                        ? const Text(
                            'Order Cancelled',
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily: medium,
                              fontSize: 16,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
