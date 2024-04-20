import 'dart:developer';

import 'package:dawaam_seller/consts/consts.dart';
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

  final totalProducts = '0'.obs;

  @override
  void onInit() {
    super.onInit();
    getTotalProducts();
  }

  addProduct() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final sellerId = prefs.getString('userId'.toString());
      log(sellerId.toString());

      if (image1.value.isEmpty ||
          image2.value.isEmpty ||
          image3.value.isEmpty ||
          image4.value.isEmpty ||
          image5.value.isEmpty) {
        Get.snackbar('Error', 'Please select all images');
        return;
      }

      // Create multipart request
      final request = http.MultipartRequest(
          'POST', Uri.parse('$baseUrl/product/add_product'));

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
      request.files
          .add(await http.MultipartFile.fromPath('images', image1.value));
      request.files
          .add(await http.MultipartFile.fromPath('images', image2.value));
      request.files
          .add(await http.MultipartFile.fromPath('images', image3.value));
      request.files
          .add(await http.MultipartFile.fromPath('images', image4.value));
      request.files
          .add(await http.MultipartFile.fromPath('images', image5.value));

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
        Get.snackbar('Error', json.decode(responseBody)['message']);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
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
        Uri.parse('$baseUrl/seller/get_products/$sellerId'),
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

  getTotalProducts() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final sellerId = prefs.getString('userId'.toString());
      // log(sellerId.toString());

      final response = await http.get(
        Uri.parse('$baseUrl/seller/get_total_products/$sellerId'),
      );

      if (response.statusCode == 200) {
        // log(response.body);
        totalProducts.value = json.decode(response.body)['length'].toString();
      } else {
        Get.snackbar('Error', json.decode(response.body)['message']);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  deleteProduct(String productId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/product/delete_product/$productId'),
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
}
