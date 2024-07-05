import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dawaam_seller/consts/consts.dart';
import 'package:dawaam_seller/widgets/back_button.dart';
import 'package:negative_padding/negative_padding.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer_pro/shimmer_pro.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final CarouselController _controller = CarouselController();
  int _current = 0;
  // final homeServiceController = Get.find<HomeServiceController>();
  final ProductController productController = Get.put(ProductController());
  final authController = Get.find<AuthController>();
  final quantity = 1.obs;

  bool isFav = false;
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var images = widget.details?['images'] as List<String>?;

    var images = widget.product.images as List<String>?;
    List<String> img = [];
    for (var i = 0; i < images!.length; i++) {
      img.insertAll(0, images);
    }
    final List<Widget> productSliders = img
        .map(
          (item) => Stack(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: '${URLServices.baseUrl}$item',
                width: 20000,
                height: 350,
                fit: BoxFit.cover,
                placeholder: (context, url) => ShimmerPro.sized(
                  light: ShimmerProLight.darker,
                  scaffoldBackgroundColor: whiteColor,
                  width: 20000,
                  height: 350,
                ),
              ),
              // Image.asset(
              //   item,
              //   fit: BoxFit.cover,
              //   width: 20000,
              //   height: 350,
              // ),
            ],
          ),
        )
        .toList();

    final CarouselController controller = CarouselController();
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      CarouselSlider(
                        items: productSliders,
                        carouselController: _controller,
                        options: CarouselOptions(
                            autoPlay: false,
                            enlargeCenterPage: false,
                            enableInfiniteScroll: true,
                            viewportFraction: 1,
                            aspectRatio: 1.3,
                            height: Image.asset(slider1).height,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current++;
                                if (_current == images.length) {
                                  _current = 0;
                                }
                              });
                            }),
                      ),
                      Positioned(
                        top: 22,
                        left: 10,
                        child: backButton(context),
                      ),
                      Positioned(
                        bottom: 30.0,
                        right: 0.0,
                        left: 0.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: whiteColor,
                              ),
                              // child: Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 6.0),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children:
                              //         products2.asMap().entries.map((entry) {
                              //       return GestureDetector(
                              //         onTap: () =>
                              //             controller.animateToPage(entry.key),
                              //         child: Container(
                              //           width: 7.0,
                              //           height: 7.0,
                              //           margin: const EdgeInsets.symmetric(
                              //               vertical: 6.0, horizontal: 3.0),
                              //           decoration: BoxDecoration(
                              //             shape: BoxShape.circle,
                              //             color: (entry.key == _current
                              //                     ? kSecondaryLightColor
                              //                     : Colors.black)
                              //                 .withOpacity(_current == entry.key
                              //                     ? 0.9
                              //                     : 0.2),
                              //           ),
                              //         ),
                              //       );
                              //     }).toList(),
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 40,
                        right: 20,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: kPrimaryLightColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: isFav
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 20,
                                    )
                                  : const Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  NegativePadding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Container(
                      // height: 100,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  widget.product.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  Text(
                                    '${widget.product.price} Rs',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    '${widget.product.oldPrice} Rs',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontFamily: regular,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: semibold,
                                color: kPrimaryLightColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ReadMoreText(
                              widget.product.description,
                              trimLines: 7,
                              colorClickableText: Colors.pink,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Read more',
                              trimExpandedText: 'Read less',
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: regular,
                                color: lightGrey,
                              ),
                              moreStyle: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: regular,
                                  color: kSecondaryLightColor),
                              lessStyle: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: regular,
                                  color: kSecondaryLightColor),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
