import 'package:dawaam_seller/consts/consts.dart';
import 'package:dawaam_seller/firebase_options.dart';
import 'package:dawaam_seller/services/notification_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  URLServices().setURL();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService().initNotifications();
  await NotificationService().startBackgroundService();
  await NotificationService().getFCMToken();
  FirebaseMessaging.onMessage.listen(NotificationService().handleNotification);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: whiteColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: whiteColor,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
