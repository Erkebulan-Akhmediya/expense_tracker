import 'package:expense_tracker/controllers/internationalization.dart';
import 'package:expense_tracker/firebase_options.dart';
import 'package:expense_tracker/root.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeData primaryTheme = ThemeData(
    primaryColor: Colors.green,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.green,
    ),
    tabBarTheme: const TabBarTheme(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.green,
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.green),
      ),
    ),
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(Colors.black),
      ),
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.green,
    ),
  );

  final ThemeData darkTheme = ThemeData(
    primaryColor: const Color(0xFFBB86Fc),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
    ),
    tabBarTheme: const TabBarTheme(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: Colors.black,
        ),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Color(0xFFBB86Fc),
      unselectedItemColor: Colors.white,
      backgroundColor: Colors.black,
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Color(0xFFBB86Fc)),
      ),
    ),
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(Colors.white),
      ),
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Color(0xFFBB86Fc),
    ),
    scaffoldBackgroundColor: const Color(0xFF151515),
  );

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: primaryTheme,
      darkTheme: darkTheme,
      translations: Internationalization(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'UK'),
      home: Root(),
    );
  }
}
