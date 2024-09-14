import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class StateController extends GetxController {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  int selectedIndex = (firebaseAuth.currentUser != null) ? 2 : 0;

  void updateSelectedIndex(int index) {
    selectedIndex = index;
    update();
  }
}
