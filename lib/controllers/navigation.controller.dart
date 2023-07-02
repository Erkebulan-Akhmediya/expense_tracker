import 'package:get/get.dart';

class NavController extends GetxController {
  RxInt currentPageIndex = 0.obs;

  void changeIndex(int index) {
    currentPageIndex.value = index;
  }
}