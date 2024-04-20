import 'package:dawaam_seller/consts/consts.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

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
              const ListTile(
                title: Text('Order ID'),
                subtitle: Text('123456789'),
              ),
              const ListTile(
                title: Text('Order Date'),
                subtitle: Text('01/01/2022 12:00 PM'),
              ),
              const ListTile(
                title: Text('Order Status'),
                subtitle: Text('Pending'),
              ),
              const ListTile(
                title: Text('Total Amount'),
                subtitle: Text('100 SAR'),
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
                title: Text('Delivery Time'),
                subtitle: Text('01/01/2022 12:00 PM'),
              ),
              const ListTile(
                title: Text('Delivery Charges'),
                subtitle: Text('10 SAR'),
              ),
              ListTile(
                title: const Text('Order Items'),
                subtitle: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.asset(
                        s1,
                        width: 50,
                      ),
                      title: Text('Product $index'),
                      subtitle: Text('Product description $index'),
                      trailing: const Text('100 SAR'),
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
