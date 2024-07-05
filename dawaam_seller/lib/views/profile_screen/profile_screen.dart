import 'dart:developer';

import 'package:dawaam_seller/consts/consts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
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
          children: [
            Column(
              children: [
                InkWell(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Change URL's"),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              TextFormField(
                                controller: controller.urlController,
                                decoration: const InputDecoration(
                                  labelText: "URL",
                                  hintText: "https://api.dawaamfoods.com",
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              final prefs = SharedPreferences.getInstance();
                              prefs.then((value) {
                                value.setString(
                                    "baseUrl", controller.urlController.text);
                              });
                              URLServices().setURL();
                              Navigator.pop(context);
                            },
                            child: const Text("Save"),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(profile),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Obx(
                  () => Text(
                    controller.name.value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    controller.email.value,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Get.to(() => const EditProfileScreen(),
                      transition: Transition.rightToLeftWithFade);
                },
                title: const Text('Edit Profile'),
                leading: const Icon(Icons.edit),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Get.to(() => const MessagesScreen(),
                      transition: Transition.rightToLeftWithFade);
                },
                title: const Text('Messages'),
                leading: const Icon(Icons.message),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  controller.logout();
                },
                title: const Text('Logout'),
                leading: const Icon(Icons.logout),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
