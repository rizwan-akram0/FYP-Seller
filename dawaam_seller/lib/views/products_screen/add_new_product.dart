import 'package:dawaam_seller/consts/consts.dart';

class AddNewProductScreen extends StatelessWidget {
  const AddNewProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
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
                      DropdownMenuItem(
                          value: 'Beverages', child: Text('Beverages')),
                      DropdownMenuItem(value: 'Snacks', child: Text('Snacks')),
                      DropdownMenuItem(
                          value: 'Personal Care', child: Text('Personal Care')),
                      DropdownMenuItem(
                          value: 'Home Care', child: Text('Home Care')),
                      DropdownMenuItem(
                          value: 'Baby Care', child: Text('Baby Care')),
                      DropdownMenuItem(value: 'Dairy', child: Text('Dairy')),
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
                                    : controller.category.value ==
                                            'Personal Care'
                                        ? [
                                            const DropdownMenuItem(
                                                value: 'Hair Care',
                                                child: Text('Hair Care')),
                                            const DropdownMenuItem(
                                                value: 'Skin Care',
                                                child: Text('Skin Care')),
                                            const DropdownMenuItem(
                                                value: 'Oral Care',
                                                child: Text('Oral Care')),
                                            const DropdownMenuItem(
                                                value: 'Feminine Hygiene',
                                                child:
                                                    Text('Feminine Hygiene')),
                                            const DropdownMenuItem(
                                                value: 'Bath & Body',
                                                child: Text('Bath & Body')),
                                          ]
                                        : controller.category.value ==
                                                'Home Care'
                                            ? [
                                                const DropdownMenuItem(
                                                    value: 'Detergents',
                                                    child: Text('Detergents')),
                                                const DropdownMenuItem(
                                                    value: 'Cleaners',
                                                    child: Text('Cleaners')),
                                                const DropdownMenuItem(
                                                    value: 'Fresheners',
                                                    child: Text('Fresheners')),
                                                const DropdownMenuItem(
                                                    value: 'Repellents',
                                                    child: Text('Repellents')),
                                              ]
                                            : controller.category.value ==
                                                    'Baby Care'
                                                ? [
                                                    const DropdownMenuItem(
                                                        value: 'Diapers',
                                                        child: Text('Diapers')),
                                                    const DropdownMenuItem(
                                                        value: 'Wipes',
                                                        child: Text('Wipes')),
                                                    const DropdownMenuItem(
                                                        value: 'Baby Food',
                                                        child:
                                                            Text('Baby Food')),
                                                    const DropdownMenuItem(
                                                        value: 'Baby Care',
                                                        child:
                                                            Text('Baby Care')),
                                                  ]
                                                : controller.category.value ==
                                                        'Dairy'
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
                height: 16,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      controller.pickImage();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.46,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Obx(() => Text(
                              controller.image1.value.isEmpty
                                  ? 'Upload Image'
                                  : 'Image 1 Uploaded',
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: medium,
                              ),
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      controller.pickImage();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.46,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Obx(() => Text(
                              controller.image2.value.isEmpty
                                  ? 'Upload Image'
                                  : 'Image 2 Uploaded',
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: medium,
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      controller.pickImage();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.46,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Obx(() => Text(
                              controller.image3.value.isEmpty
                                  ? 'Upload Image'
                                  : 'Image 3 Uploaded',
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: medium,
                              ),
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      controller.pickImage();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.46,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Obx(() => Text(
                              controller.image4.value.isEmpty
                                  ? 'Upload Image'
                                  : 'Image 4 Uploaded',
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: medium,
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  controller.pickImage();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Obx(() => Text(
                          controller.image5.value.isEmpty
                              ? 'Upload Image'
                              : 'Image 5 Uploaded',
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: medium,
                          ),
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  controller.addProduct();
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
                      'Add Product',
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
