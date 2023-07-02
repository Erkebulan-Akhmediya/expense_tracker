import 'package:expense_tracker/controllers/navigation.controller.dart';
import 'package:expense_tracker/firebase_options.dart';
import 'package:expense_tracker/root.dart';
import 'package:expense_tracker/views/home/home.dart';
import 'package:expense_tracker/views/profile/profile.dart';
import 'package:expense_tracker/views/statictics/statistics.dart';
import 'package:expense_tracker/views/wallet.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Root(),
      getPages: [
        GetPage(name: '/home', page: () => const Home()),
        GetPage(name: '/statistics', page: () => const Statistics()),
        GetPage(name: '/wallet', page: () => const Wallet()),
        GetPage(name: '/profile', page: () => Profile()),
      ],
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => NavController());
      }),
    );
  }
}
