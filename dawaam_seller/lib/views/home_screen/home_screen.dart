import 'package:dawaam_seller/consts/consts.dart';
import 'package:dawaam_seller/widgets/dashboard_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Dashboard',
            style: TextStyle(
              color: kPrimaryLightColor,
              fontFamily: medium,
              fontSize: 16,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Obx(
                () => dashboardButton(context,
                    title: 'Products',
                    count: productController.totalProducts.value,
                    icon: box),
              ),
              const SizedBox(
                height: 10,
              ),
              dashboardButton(context,
                  title: 'Orders', count: '25', icon: icOrders),
            ],
          ),
        ));
  }
}
