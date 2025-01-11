import 'package:e_commerce/shared_pref/shared_preferences.dart';
import 'package:e_commerce/src/layout/layout_view.dart';
import 'package:e_commerce/src/products/products_view.dart';
import 'package:e_commerce/src/auth/login/login_view.dart';
import 'package:e_commerce/src/auth/register/register_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String main = '/main';
  static const String product = '/products';

 static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
  initialLocation:AppRoutes.login ,
  redirect: (context, state) async{
    final token = await SharedPreferencesHelper.getString('token');
    final isAuthenticated = token != null && token.isNotEmpty;

    if (!isAuthenticated) {
      return AppRoutes.login;
    }

    return AppRoutes.main; 
  },
  routes: [

    GoRoute(
      path: '/',
      redirect: (context, state) => AppRoutes.login,
    ),
      GoRoute(
      path: AppRoutes.main,
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.product,
      builder: (context, state) => const ProductsSecreen(),
    ),
  ],
);


}





Future<String?> isToken()async {
  final String? token = await SharedPreferencesHelper.getString('token');
  return token;
}