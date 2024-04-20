import 'package:cached_network_image/cached_network_image.dart';
import 'package:dawaam_seller/consts/consts.dart';
import 'package:shimmer_pro/shimmer_pro.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
          style: TextStyle(
            color: kPrimaryLightColor,
            fontFamily: medium,
            fontSize: 16,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add new product',
        onPressed: () {
          Get.to(() => const AddNewProductScreen(),
              transition: Transition.rightToLeftWithFade);
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: StreamBuilder(
          stream: productController.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
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
            }

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return Card(
                  child: ListTile(
                      onTap: () {
                        Get.to(() => const ProductDetailsScreen(),
                            transition: Transition.rightToLeftWithFade);
                      },
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          imageUrl: '$baseUrl${product.images[0]}',
                          placeholder: (context, url) => ShimmerPro.sized(
                              borderRadius: 2,
                              scaffoldBackgroundColor: lightGrey,
                              height: 50,
                              width: 60),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.photo_size_select_large_rounded),
                          width: 60,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(product.name,
                          maxLines: 1, overflow: TextOverflow.ellipsis),
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
                                productController.deleteProduct(product.id);
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
      ),
    );
  }
}
