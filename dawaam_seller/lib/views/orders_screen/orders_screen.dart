import 'package:dawaam_seller/consts/consts.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Get.to(() => const OrderDetailScreen(),
                      transition: Transition.rightToLeftWithFade);
                },
                leading: Image.asset(
                  icOrders,
                  width: 40,
                ),
                title: Text('Order $index'),
                subtitle: const Text('01/01/2022 12:00 PM'),
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
        ),
      ),
    );
  }
}
