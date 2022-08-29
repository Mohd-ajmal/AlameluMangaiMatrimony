import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:matrimony/screens/HomeScreen/HomeScreen.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/ProfileImage.dart';

import 'package:matrimony/screens/SignIn&SignUpScreen/SignIn.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/SignUp.dart';
import 'package:matrimony/screens/SplashScreen/SplashScreen.dart';
import 'package:matrimony/screens/payment_screen/payment_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelHiveAdapter());
  await Hive.openBox<UserModelHive>('transaction');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/signin': (context) => const SignIn(),
        '/signup': (context) => const SignUp(),
        '/home': (context) => const HomeScreen3(),
        '/profileimage1': (context) => const ProfileImageUpdate(),
        '/paymentGateway': (context) => const PaymentGateway1(),
      },
    );
  }
}
// flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi
