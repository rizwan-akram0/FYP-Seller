import 'package:dawaam_seller/consts/consts.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Messages',
          style: TextStyle(
            color: kPrimaryLightColor,
            fontFamily: medium,
            fontSize: 16,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                Get.to(() => const ChatScreen(),
                    transition: Transition.rightToLeftWithFade);
              },
              leading: const CircleAvatar(
                backgroundImage: AssetImage(profile),
              ),
              title: Text('User $index'),
              subtitle: Text('Message $index'),
              trailing: const Text('12:00 PM'),
            ),
          );
        },
      ),
    );
  }
}
