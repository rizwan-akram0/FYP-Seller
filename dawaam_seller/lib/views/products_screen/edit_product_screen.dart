import 'package:dawaam_seller/consts/consts.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  final String productId;
  const EditProductScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.put(ProductController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Product',
          style: TextStyle(
            color: kPrimaryLightColor,
            fontFamily: medium,
            fontSize: 16,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              TextFormField(
                controller: controller.nameController,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  labelText: 'Product Name',
                  labelStyle: const TextStyle(fontSize: 14, fontFamily: medium),
                  floatingLabelStyle:
                      const TextStyle(color: kSecondaryLightColor),
                  hintText: 'Enter Product Name',
                  hintStyle: const TextStyle(fontSize: 14, fontFamily: medium),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: kSecondaryLightColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: kSecondaryLightColor),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.46,
                    child: TextFormField(
                      controller: controller.priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        labelText: 'Price',
                        labelStyle:
                            const TextStyle(fontSize: 14, fontFamily: medium),
                        floatingLabelStyle:
                            const TextStyle(color: kSecondaryLightColor),
                        hintText: 'Enter Price',
                        hintStyle:
                            const TextStyle(fontSize: 14, fontFamily: medium),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: kSecondaryLightColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: kSecondaryLightColor),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.46,
                    child: TextFormField(
                      controller: controller.oldPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        labelText: 'Old Price',
                        labelStyle:
                            const TextStyle(fontSize: 14, fontFamily: medium),
                        floatingLabelStyle:
                            const TextStyle(color: kSecondaryLightColor),
                        hintText: 'Enter Old Price',
                        hintStyle:
                            const TextStyle(fontSize: 14, fontFamily: medium),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: kSecondaryLightColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: kSecondaryLightColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.descriptionController,
                minLines: 5,
                maxLines: 20,
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.top,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  labelText: 'Description',
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  alignLabelWithHint: true,
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontFamily: medium,
                  ),
                  floatingLabelStyle:
                      const TextStyle(color: kSecondaryLightColor),
                  hintText: 'Enter Product Description',
                  hintStyle: const TextStyle(fontSize: 14, fontFamily: medium),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: kSecondaryLightColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: kSecondaryLightColor),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Obx(
                  () => DropdownButton(
                    underline: Container(),
                    items: const [
                      DropdownMenuItem(value: 'Spices', child: Text('Spices')),
                      DropdownMenuItem(
                          value: 'Grocery', child: Text('Grocery')),
                      DropdownMenuItem(value: 'Diary', child: Text('Diary')),
                      DropdownMenuItem(value: 'Fruits', child: Text('Fruits')),
                      DropdownMenuItem(
                          value: 'Vegetables', child: Text('Vegetables')),
                      DropdownMenuItem(
                          value: 'Beverages', child: Text('Beverages')),
                      DropdownMenuItem(value: 'Snacks', child: Text('Snacks')),
                      DropdownMenuItem(
                          value: 'Dry Fruits', child: Text('Dry Fruits')),
                    ],
                    onChanged: (value) {
                      controller.subCategory.value = '';
                      controller.category.value = value!;
                    },
                    hint: const Text('Select Category'),
                    value: controller.category.value.toString().isEmpty
                        ? null
                        : controller.category.value,
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Obx(
                  () => DropdownButton(
                    underline: Container(),
                    items: controller.category.value == 'Spices'
                        ? [
                            const DropdownMenuItem(
                                value: 'Whole Spices',
                                child: Text('Whole Spices')),
                            const DropdownMenuItem(
                                value: 'Powdered Spices',
                                child: Text('Powdered Spices')),
                            const DropdownMenuItem(
                                value: 'Mixed Spices',
                                child: Text('Mixed Spices')),
                          ]
                        : controller.category.value == 'Grocery'
                            ? [
                                const DropdownMenuItem(
                                    value: 'Pulses', child: Text('Pulses')),
                                const DropdownMenuItem(
                                    value: 'Rice', child: Text('Rice')),
                                const DropdownMenuItem(
                                    value: 'Flour', child: Text('Flour')),
                                const DropdownMenuItem(
                                    value: 'Sugar', child: Text('Sugar')),
                                const DropdownMenuItem(
                                    value: 'Salt', child: Text('Salt')),
                                const DropdownMenuItem(
                                    value: 'Oil', child: Text('Oil')),
                              ]
                            : controller.category.value == 'Beverages'
                                ? [
                                    const DropdownMenuItem(
                                        value: 'Tea', child: Text('Tea')),
                                    const DropdownMenuItem(
                                        value: 'Coffee', child: Text('Coffee')),
                                    const DropdownMenuItem(
                                        value: 'Soft Drinks',
                                        child: Text('Soft Drinks')),
                                    const DropdownMenuItem(
                                        value: 'Juices', child: Text('Juices')),
                                  ]
                                : controller.category.value == 'Snacks'
                                    ? [
                                        const DropdownMenuItem(
                                            value: 'Chips',
                                            child: Text('Chips')),
                                        const DropdownMenuItem(
                                            value: 'Biscuits',
                                            child: Text('Biscuits')),
                                        const DropdownMenuItem(
                                            value: 'Namkeen',
                                            child: Text('Namkeen')),
                                        const DropdownMenuItem(
                                            value: 'Chocolates',
                                            child: Text('Chocolates')),
                                      ]
                                    : controller.category.value == 'Dry Fruits'
                                        ? [
                                            const DropdownMenuItem(
                                                value: 'Dry Fruits',
                                                child: Text('Dry Fruits')),
                                          ]
                                        : controller.category.value ==
                                                'Vegetables'
                                            ? [
                                                const DropdownMenuItem(
                                                    value: 'Fresh Vegetables',
                                                    child: Text(
                                                        'Fresh Vegetables')),
                                              ]
                                            : controller.category.value ==
                                                    'Fruits'
                                                ? [
                                                    const DropdownMenuItem(
                                                        value: 'Fresh Fruits',
                                                        child: Text(
                                                            'Fresh Fruits')),
                                                    const DropdownMenuItem(
                                                        value: 'Frozen Fruits',
                                                        child: Text(
                                                            'Frozen Fruits')),
                                                    const DropdownMenuItem(
                                                        value:
                                                            'Packaged Fruits',
                                                        child: Text(
                                                            'Packaged Fruits')),
                                                  ]
                                                : controller.category.value ==
                                                        'Diary'
                                                    ? [
                                                        const DropdownMenuItem(
                                                            value: 'Milk',
                                                            child:
                                                                Text('Milk')),
                                                        const DropdownMenuItem(
                                                            value: 'Curd',
                                                            child:
                                                                Text('Curd')),
                                                        const DropdownMenuItem(
                                                            value: 'Butter',
                                                            child:
                                                                Text('Butter')),
                                                        const DropdownMenuItem(
                                                            value: 'Cheese',
                                                            child:
                                                                Text('Cheese')),
                                                      ]
                                                    : [
                                                        const DropdownMenuItem(
                                                            value:
                                                                'Select SubCategory',
                                                            child: Text(
                                                                'Select SubCategory')),
                                                      ],
                    onChanged: (value) {
                      controller.subCategory.value = value!;
                    },
                    value: controller.subCategory.value.toString().isEmpty
                        ? null
                        : controller.subCategory.value,
                    hint: const Text('Select SubCategory'),
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: controller.stockController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  labelText: 'Stock',
                  labelStyle: const TextStyle(fontSize: 14, fontFamily: medium),
                  floatingLabelStyle:
                      const TextStyle(color: kSecondaryLightColor),
                  hintText: 'Enter Stock Number',
                  hintStyle: const TextStyle(fontSize: 14, fontFamily: medium),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: kSecondaryLightColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: kSecondaryLightColor),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                maxLines: 3,
                minLines: 1,
                controller: controller.tagsController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  labelText: 'Tags',
                  labelStyle: const TextStyle(fontSize: 14, fontFamily: medium),
                  floatingLabelStyle:
                      const TextStyle(color: kSecondaryLightColor),
                  hintText: 'Enter Tags separated by commas',
                  hintStyle: const TextStyle(fontSize: 14, fontFamily: medium),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: kSecondaryLightColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: kSecondaryLightColor),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  controller.editProduct(productId, context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Edit Product',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: medium,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
