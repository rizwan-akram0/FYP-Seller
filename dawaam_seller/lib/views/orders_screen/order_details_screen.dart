import 'package:cached_network_image/cached_network_image.dart';
import 'package:dawaam_seller/consts/consts.dart';
import 'package:dawaam_seller/models/orders_model.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderElement order;
  const OrderDetailScreen({super.key, required this.order});

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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              ListTile(
                title: const Text('Order ID'),
                subtitle: Text(order.orderId),
              ),
              ListTile(
                title: const Text('Order Date'),
                subtitle: Text(order.createdAt.toLocal().toString()),
              ),
              ListTile(
                title: const Text('Order Status'),
                subtitle: Text(order.status.toString()),
              ),
              ListTile(
                title: const Text('Total Amount'),
                subtitle: Text(order.totalAmount.toString()),
              ),
              const ListTile(
                title: Text('Payment Method'),
                subtitle: Text('Cash on delivery'),
              ),
              const ListTile(
                title: Text('Delivery Address'),
                subtitle: Text('Riyadh, Saudi Arabia'),
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
                    return ListTile(
                      leading: CachedNetworkImage(
                        imageUrl:
                            '$baseUrl${order.items[index].productId.images.first}',
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
                        order.items[index].productId.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        order.items[index].productId.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing:
                          Text(order.items[index].productId.price.toString()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
