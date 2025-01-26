import 'package:e_commerce/language/localiztion.dart';
import 'package:e_commerce/routes/app_routes.dart';
import 'package:e_commerce/shared_pref/shared_preferences.dart';
import 'package:e_commerce/src/auth/login/login_view.dart';
import 'package:e_commerce/src/layout/layout_view.dart';
import 'package:e_commerce/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String? token = await SharedPreferencesHelper.getString('token');
  final String? lang = await SharedPreferencesHelper.getString('lang');
  runApp(MyApp(token: token, lang: lang));
}

class MyApp extends StatelessWidget {
  final String? token;
  final String? lang;

  const MyApp({Key? key, this.token, this.lang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale(lang ?? 'en'),
      translations: LocaliztionApp(),
      fallbackLocale: const Locale('en'),
      title: 'Shop app',
      theme: ThemeApp.light,
      darkTheme: ThemeApp.dark,
      themeMode: ThemeMode.system,
      getPages: AppRoute.router,
      home: token == null ? const LoginView() : const MainView(),
    );
  }
}
