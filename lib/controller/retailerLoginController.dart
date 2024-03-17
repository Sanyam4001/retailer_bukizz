import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retailer_bukizz/constants/constants.dart';
import 'package:retailer_bukizz/ui/NavBar/NavBar.dart';
import 'package:retailer_bukizz/models/home_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/retailer model.dart';

class RetailerLoginController extends GetxController {
  TextEditingController retailerIdController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  var retailer = Rxn<RetailerModel>();
  var orders = <HomeModel>[].obs;
  var fetchedOrderIds = <String>{};

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn.value) {

      await fetchRetailerDetails(prefs.getString('retailerId') ?? '');
    }
  }

  Future<void> login(BuildContext context) async {
    isLoading(true);
    // AppConstants.buildShowDialog(context);
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      AppConstants.isLogin = true;

      // Login successful, save login state
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('retailerId', retailerIdController.text);
      isLoggedIn.value = true;


      await fetchRetailerDetails(retailerIdController.text);

      Get.snackbar('Success', 'Retailer logged in successfully',
          snackPosition: SnackPosition.TOP);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NavBarScreen()),
      );
    } catch (error) {
      Get.snackbar('Error', 'Failed to login: $error',
          snackPosition: SnackPosition.TOP);
    }
    isLoading(false);
  }

  Future<void> fetchRetailerDetails(String retailerId) async {
    try {
      var retailerDoc = await FirebaseFirestore.instance
          .collection('Retailers')
          .doc(retailerId)
          .get();

      var retailerData = retailerDoc.data();
      if (retailerData != null) {
        retailer.value = RetailerModel.fromMap(retailerData);
        // Store retailer details in AppConstants
        AppConstants.userData = retailer.value!;
      }
    } catch (error) {
      print('Error fetching retailer details: $error');
    }
  }

  Future<void> logout() async {
    isLoading(true);
    try {
      await FirebaseAuth.instance.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);
      isLoggedIn.value = false;

      Get.snackbar('Success', 'Retailer logged out successfully',
          snackPosition: SnackPosition.TOP);
    } catch (error) {
      Get.snackbar('Error', 'Failed to logout: $error',
          snackPosition: SnackPosition.TOP);
    }
    isLoading(false);
  }
}
