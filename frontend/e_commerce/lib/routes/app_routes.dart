import 'package:e_commerce/shared_pref/shared_preferences.dart';
import 'package:e_commerce/src/auth/otp/enter_otp/enter_otp_view.dart';
import 'package:e_commerce/src/auth/otp/otp_view.dart';
import 'package:e_commerce/src/layout/layout_view.dart';
import 'package:e_commerce/src/products/products_view.dart';
import 'package:e_commerce/src/auth/login/login_view.dart';
import 'package:e_commerce/src/auth/register/register_view.dart';
import 'package:e_commerce/src/products_category/products_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String main = '/main';
  static const String product = '/products';
  static const String prouductsCategory = '/prouductsCategory';
  static const String otp = '/otp';
  static const String enterOtp = '/enter-otp';

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoutes.main,
    redirect: (context, state) async {
      final token = await SharedPreferencesHelper.getString('token');
      final isAuthenticated = token != null && token.isNotEmpty;

      if (!isAuthenticated) {
        return AppRoutes.login;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: AppRoutes.otp,
        builder: (context, state) => const OtpView(),
      ),
      GoRoute(
        path: AppRoutes.enterOtp,
        builder: (context, state) => const EnterOtp(),
      ),
      GoRoute(
        path: AppRoutes.main,
        builder: (context, state) => const MainView(),
      ),
      GoRoute(
        path: AppRoutes.product,
        builder: (context, state) => const ProductsView(),
      ),
      GoRoute(
        path: AppRoutes.prouductsCategory,
        builder: (context, state) => const ProductsCategoryView(),
      ),
    ],
  );
}
