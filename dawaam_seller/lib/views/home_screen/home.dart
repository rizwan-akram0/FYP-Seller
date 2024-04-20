import 'package:dawaam_seller/consts/consts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navScreens = [
      const HomeScreen(),
      const ProductsScreen(),
      const OrdersScreen(),
      const ProfileScreen(),
    ];

    var bottomNavbar = [
      BottomNavigationBarItem(
        icon: Image.asset(
          icHome,
          width: 24,
          color: greyColor,
        ),
        label: 'Dashboard',
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          box,
          width: 24,
          color: greyColor,
        ),
        label: 'Products',
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          icOrders,
          width: 24,
          color: greyColor,
        ),
        label: 'Orders',
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          icSettings,
          width: 24,
          color: greyColor,
        ),
        label: 'Settings',
      ),
    ];
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            onTap: (index) {
              controller.navIndex.value = index;
            },
            currentIndex: controller.navIndex.value,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: kPrimaryLightColor,
            unselectedItemColor: greyColor,
            items: bottomNavbar),
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(child: navScreens.elementAt(controller.navIndex.value)),
          ],
        ),
      ),
    );
  }
}
