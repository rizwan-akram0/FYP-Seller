import 'package:dawaam_seller/consts/consts.dart';
import 'package:dawaam_seller/models/user_model.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
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
      body: StreamBuilder<List<User>>(
        stream: authController.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'No messages found',
              ),
            );
          }
          final users = snapshot.data!;

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {
                    Get.to(
                        () => ChatScreen(
                            senderId: authController.userId.value,
                            recipientId: '2'),
                        transition: Transition.rightToLeftWithFade);
                  },
                  leading: Image.asset(icMessages, width: 40, height: 40),
                  title: Text(users[index].name),
                  subtitle: const Text('Message '),
                  // trailing: const Text('12:00 PM'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
