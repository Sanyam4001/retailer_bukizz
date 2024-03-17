import 'package:get/get.dart';

class BottomNavController extends GetxController {
  // Index of the currently selected tab
  var currentIndex = 0.obs;

  // Function to change the selected tab
  void changeTabIndex(int index) {
    currentIndex.value = index;
  }
}
