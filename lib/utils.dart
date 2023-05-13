import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppController extends GetxController {
  var token = "".obs;

  @override
  void onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token')!;
    super.onInit();
  }
}
