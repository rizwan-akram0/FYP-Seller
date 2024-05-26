import 'package:cached_network_image/cached_network_image.dart';
import 'package:dawaam_seller/consts/consts.dart';
import 'package:dawaam_seller/widgets/dashboard_button.dart';
import 'package:shimmer_pro/shimmer_pro.dart';

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
              Obx(
                () => dashboardButton(context,
                    title: 'Orders',
                    count: productController.totalOrders.value,
                    icon: box),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Column(
                children: [
                  const Text(
                    'Popular Products',
                    style: TextStyle(
                      color: kPrimaryLightColor,
                      fontFamily: medium,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: StreamBuilder<List<Product>>(
                      stream: productController.getPopularProducts(),
                      builder: (context, snapshot) {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final product = snapshot.data![index];
                            return Card(
                              child: ListTile(
                                  onTap: () {
                                    Get.to(
                                        () => ProductDetailsScreen(
                                              product: product,
                                            ),
                                        transition:
                                            Transition.rightToLeftWithFade);
                                  },
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: CachedNetworkImage(
                                      imageUrl: '$baseUrl${product.images[0]}',
                                      placeholder: (context, url) =>
                                          ShimmerPro.sized(
                                              borderRadius: 2,
                                              scaffoldBackgroundColor:
                                                  lightGrey,
                                              height: 50,
                                              width: 60),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons
                                              .photo_size_select_large_rounded),
                                      width: 60,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(product.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                  subtitle: Text(
                                    product.description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: PopupMenuButton(
                                    itemBuilder: (context) => [
                                      const PopupMenuItem(
                                        child: ListTile(
                                          title: Text('Edit'),
                                          leading: Icon(Icons.edit),
                                        ),
                                      ),
                                      PopupMenuItem(
                                        child: ListTile(
                                          onTap: () {
                                            productController
                                                .deleteProduct(product.id);
                                          },
                                          title: const Text('Delete'),
                                          leading: const Icon(Icons.delete),
                                        ),
                                      ),
                                    ],
                                  )),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ))
            ],
          ),
        ));
  }
}
