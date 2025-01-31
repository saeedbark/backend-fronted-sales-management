import 'package:e_commerce/constent/my_string.dart';
import 'package:e_commerce/shared_pref/shared_preferences.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  var switchValue = false.obs;
  // var storage = GetStorage();
  var langLocal = ene;

  // String capitalize(String profileName) {
  //   return profileName.split(" ").map((name) => name.capitalize).join(" ");
  // }

// language
  @override
  void onInit() async {
    super.onInit();
    langLocal = await getLanguage;
  }

  void saveLanguage(String lang) async {
    await SharedPreferencesHelper.setString("lang", lang);
  }

  Future<String> get getLanguage async {
    return await SharedPreferencesHelper.getString("lang") ?? ene;
  }

  void changeLanguage(String typeLang) {
    saveLanguage(typeLang);
    if (langLocal == typeLang) {
      return;
    } else if (typeLang == frf) {
      langLocal = frf;
      saveLanguage(frf);
    } else if (typeLang == ara) {
      langLocal = ara;
      saveLanguage(ara);
    } else {
      langLocal = ene;
      saveLanguage(ene);
    }

    update();
    // Get.updateLocale(Locale(typeLang));
    // update();
  }
}
