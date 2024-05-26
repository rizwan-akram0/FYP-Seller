import 'package:dawaam_seller/consts/consts.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(
            color: kPrimaryLightColor,
            fontFamily: medium,
            fontSize: 16,
          ),
        ),
      ),
      body: Container(),
    );
  }
}
