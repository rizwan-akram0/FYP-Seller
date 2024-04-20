import 'package:dawaam_seller/consts/consts.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: kPrimaryLightColor,
            fontFamily: medium,
            fontSize: 16,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(profile),
            ),
            const SizedBox(
              width: 15,
            ),
            InputField(
              hint: 'Enter Name',
              label: 'Name',
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              controller: controller.nameController,
            ),
            const SizedBox(
              height: 10,
            ),
            const PasswordInputField(controller: null),
            const SizedBox(
              height: 10,
            ),
            const PasswordInputField(
              controller: null,
              hint: 'Confirm Password',
              label: 'Confirm Password',
            ),
            const Spacer(),
            LargeButton(
              title: 'Save',
              onPress: () {},
            ),
          ],
        ),
      ),
    );
  }
}
