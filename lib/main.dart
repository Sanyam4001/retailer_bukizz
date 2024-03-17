import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:retailer_bukizz/constants/theme.dart';
import 'package:retailer_bukizz/ui/Login/Signin_Screen.dart';
import 'package:retailer_bukizz/ui/NavBar/NavBar.dart';

import 'controller/retailerLoginController.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightThemeData,
        home: const SplashScreen(),
      );
    });
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RetailerLoginController>(
      init: RetailerLoginController(),
      builder: (loginController) {
        return Obx(() {
          if (loginController.isLoggedIn.value) {
            return NavBarScreen();
          } else {
            return SignIn();
          }
        });
      },
    );
  }
}
