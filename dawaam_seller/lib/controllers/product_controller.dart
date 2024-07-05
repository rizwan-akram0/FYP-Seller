import 'dart:developer';

import 'package:dawaam_seller/consts/consts.dart';
import 'package:dawaam_seller/views/products_screen/edit_product_screen.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final oldPriceController = TextEditingController();
  final descriptionController = TextEditingController();
  final stockController = TextEditingController();
  final tagsController = TextEditingController();
  final category = ''.obs;
  final subCategory = ''.obs;
  final image1 = ''.obs;
  final image2 = ''.obs;
  final image3 = ''.obs;
  final image4 = ''.obs;
  final image5 = ''.obs;
  final totalOrders = '0'.obs;

  final totalProducts = '0'.obs;

  @override
  void onInit() {
    super.onInit();
    getTotalProducts();
    getTotalOrders();
  }

  getTotalOrders() async {
    try {
      final authController = Get.put(AuthController());
      final response = await http.get(
        Uri.parse(
            '${URLServices.baseUrl}/order/total_orders_by_seller/${authController.userId.value}'),
      );
      log('User IUD: ${authController.userId.toString()}');

      if (response.statusCode == 200) {
        log(response.body);
        totalOrders.value =
            json.decode(response.body)['totalOrders'].toString();
      } else {
        // Get.snackbar('Error', json.decode(response.body)['message']);
      }
    } catch (e) {
      // Get.snackbar('Error', e.toString());
    }
  }

  addProduct() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final sellerId = prefs.getString('userId'.toString());
      log(sellerId.toString());

      if (image1.value.isEmpty
          //  ||
          // image2.value.isEmpty ||
          // image3.value.isEmpty ||
          // image4.value.isEmpty ||
          // image5.value.isEmpty
          ) {
        Get.snackbar('Error', 'Please select all images');
        return;
      }

      // Create multipart request
      final request = http.MultipartRequest(
          'POST', Uri.parse('${URLServices.baseUrl}/product/add_product'));

      // Add form fields
      request.fields['name'] = nameController.text;
      request.fields['price'] = priceController.text;
      request.fields['oldPrice'] = oldPriceController.text;
      request.fields['description'] = descriptionController.text;
      request.fields['category'] = category.value;
      request.fields['subCategory'] = subCategory.value;
      request.fields['stock'] = stockController.text;
      // request.fields['tags'] = tagsController.text;
      request.fields['sellerId'] = sellerId ?? '';

      // Split and add tags as an array
      request.fields['tags'] = tagsController.text;

      // Add images to multipart request
      if (image1.value.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath('images', image1.value));
      }
      if (image2.value.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath('images', image2.value));
      }
      if (image3.value.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath('images', image3.value));
      }
      if (image4.value.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath('images', image4.value));
      }
      if (image5.value.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath('images', image5.value));
      }

      // request.files
      //     .add(await http.MultipartFile.fromPath('images', image1.value));
      // request.files
      //     .add(await http.MultipartFile.fromPath('images', image2.value));
      // request.files
      //     .add(await http.MultipartFile.fromPath('images', image3.value));
      // request.files
      //     .add(await http.MultipartFile.fromPath('images', image4.value));
      // request.files
      //     .add(await http.MultipartFile.fromPath('images', image5.value));

      // Send the request
      final response = await request.send();

      // Get response body
      final responseBody = await response.stream.bytesToString();

      // Check the status code of the response
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Product added successfully');
        // Clear controllers and image paths
        clearFields();
        // Get total products
        getTotalProducts();
      } else {
        log(responseBody);
        Get.snackbar('Error', json.decode(responseBody)['message']);
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar('Error', e.toString());
    }
  }

  getDetailsofProductForEdit(Product product) {
    try {
      final tag = product.tag.toString();
      final tagsString = tag.substring(1, tag.length - 1);
      nameController.text = product.name;
      priceController.text = product.price.toString();
      oldPriceController.text = product.oldPrice.toString();
      descriptionController.text = product.description;
      stockController.text = product.stock.toString();
      tagsController.text = tagsString;
      category.value = product.category;
      subCategory.value = product.subCategory;
      Get.to(() => EditProductScreen(
            productId: product.id,
          ));
    } catch (e) {}
  }

// Function to clear controllers and image paths
  clearFields() {
    nameController.clear();
    priceController.clear();
    oldPriceController.clear();
    descriptionController.clear();
    stockController.clear();
    tagsController.clear();
    category.value = '';
    subCategory.value = '';
    image1.value = '';
    image2.value = '';
    image3.value = '';
    image4.value = '';
    image5.value = '';
  }

  pickImage() {
    try {
      checkPermission();
      final picker = ImagePicker();
      picker.pickImage(source: ImageSource.gallery).then((value) {
        if (value != null) {
          // log(value.path);
          if (image1.value.isEmpty) {
            image1.value = value.path;
          } else if (image2.value.isEmpty) {
            image2.value = value.path;
          } else if (image3.value.isEmpty) {
            image3.value = value.path;
          } else if (image4.value.isEmpty) {
            image4.value = value.path;
          } else if (image5.value.isEmpty) {
            image5.value = value.path;
          }
        }
      });
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Stream<List<Product>> getProducts() async* {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final sellerId = prefs.getString('userId'.toString());
      // log(sellerId.toString());

      final response = await http.get(
        Uri.parse('${URLServices.baseUrl}/seller/get_products/$sellerId'),
      );

      if (response.statusCode == 200) {
        log(response.body);
        List<Product> products;

        products = (json.decode(response.body) as List)
            .map((data) => Product.fromJson(data))
            .toList();

        yield products;
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar('Error', e.toString());
    }
  }

  getTotalProducts() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final sellerId = prefs.getString('userId'.toString());
      // log(sellerId.toString());

      final response = await http.get(
        Uri.parse('${URLServices.baseUrl}/seller/get_total_products/$sellerId'),
      );

      if (response.statusCode == 200) {
        // log(response.body);
        totalProducts.value = json.decode(response.body)['length'].toString();
      } else {
        // Get.snackbar('Error', json.decode(response.body)['message']);
      }
    } catch (e) {
      // Get.snackbar('Error', e.toString());
    }
  }

  deleteProduct(String productId) async {
    try {
      final response = await http.delete(
        Uri.parse('${URLServices.baseUrl}/product/delete_product/$productId'),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Product deleted successfully');
        getTotalProducts();
      } else {
        Get.snackbar('Error', json.decode(response.body)['message']);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  checkPermission() async {
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  Stream<List<Product>> getPopularProducts() async* {
    try {
      final authController = Get.put(AuthController());
      final response = await http.get(
        Uri.parse(
            '${URLServices.baseUrl}/product/get_popular_products_by_seller/${authController.userId.value}'),
      );

      if (response.statusCode == 200) {
        log(response.body);
        List<Product> products;

        products = (json.decode(response.body) as List)
            .map((data) => Product.fromJson(data))
            .toList();

        yield products;
      } else {
        log(json.decode(response.body)['message']);
        Get.snackbar('Error', json.decode(response.body)['message']);
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar('Error', e.toString());
    }
  }

  editProduct(String id, context) async {
    try {
      if (nameController.text.isEmpty ||
          priceController.text.isEmpty ||
          descriptionController.text.isEmpty ||
          category.isEmpty ||
          subCategory.isEmpty ||
          stockController.text.isEmpty ||
          tagsController.text.isEmpty) {
        Get.snackbar('Error', 'All Fields are required');
        return;
      }
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final sellerId = prefs.getString('userId'.toString());
      final body = {
        'name': nameController.text,
        'price': priceController.text,
        'oldPrice': oldPriceController.text,
        'description': descriptionController.text,
        'category': category.value,
        'subCategory': subCategory.value,
        'stock': stockController.text,
        'sellerId': sellerId,
        'tag': tagsController.text
      };

      final response = await http.put(
          Uri.parse('${URLServices.baseUrl}/product/edit_product/$id'),
          body: body);

      print(response.statusCode);

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Product Update Successfully');
        Navigator.pop(context);
      } else {
        Get.snackbar('Error', 'Something Went wrong');
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'Something went wrong');
    }
  }
}
