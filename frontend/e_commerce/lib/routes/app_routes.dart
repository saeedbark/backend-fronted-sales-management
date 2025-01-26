import 'package:e_commerce/src/auth/otp/otp_view.dart';
import 'package:e_commerce/src/layout/layout_view.dart';
import 'package:e_commerce/src/products/products_view.dart';
import 'package:e_commerce/src/auth/login/login_view.dart';
import 'package:e_commerce/src/auth/register/register_view.dart';
import 'package:e_commerce/src/products_category/products_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoute {
  static const String login = '/login';
  static const String register = '/register';
  static const String main = '/main';
  static const String product = '/products';
  static const String prouductsCategory = '/prouductsCategory';
  static const String otp = '/otp';
  static const String enterOtp = '/enter-otp';
  static const String cart = '/cart';

  static final router = [
    GetPage(
      name: AppRoute.login,
      page: () => const LoginView(),
    ),
    GetPage(
      name: AppRoute.register,
      page: () => const RegisterView(),
    ),
    GetPage(
      name: AppRoute.otp,
      page: () => const OtpView(),
    ),
    // GetPage(
    //   name: AppRoute.enterOtp,
    //   page: () => const EnterOtp(),
    // ),
    GetPage(
      name: AppRoute.main,
      page: () => const MainView(),
    ),
    GetPage(
      name: AppRoute.product,
      page: () => const ProductsView(),
    ),
    GetPage(
      name: AppRoute.prouductsCategory,
      page: () => const ProductsCategoryView(),
    ),
  ];
}
















































// class AppRoutes {
//   static const String login = '/login';
//   static const String register = '/register';
//   static const String main = '/main';
//   static const String product = '/products';
//   static const String prouductsCategory = '/prouductsCategory';
//   static const String otp = '/otp';
//   static const String enterOtp = '/enter-otp';
//   static const String cart = '/cart';

//   static final GlobalKey<NavigatorState> navigatorKey =
//       GlobalKey<NavigatorState>();

//   static final GoRouter router = GoRouter(
//     navigatorKey: navigatorKey,
//     initialLocation: AppRoutes.main,
//     redirect: (context, state) async {
//       final token = await SharedPreferencesHelper.getString('token');
//       final code = await SharedPreferencesHelper.getString('code');
//       final isAuthenticated = token != null && token.isNotEmpty;

//       if (!isAuthenticated) {
//         return AppRoutes.login;
//       }

//       return null;
//     },
//     routes: [
//       GoRoute(
//         path: AppRoutes.login,
//         builder: (context, state) => const LoginView(),
//       ),
//       GoRoute(
//         path: AppRoutes.register,
//         builder: (context, state) => const RegisterView(),
//       ),
//       GoRoute(
//         path: AppRoutes.otp,
//         builder: (context, state) => const OtpView(),
//       ),
//       // GoRoute(
//       //   path: AppRoutes.enterOtp,
//       //   builder: (context, state) => const EnterOtp(),
//       // ),
//       GoRoute(
//         path: AppRoutes.main,
//         builder: (context, state) => const MainView(),
//       ),
//       GoRoute(
//         path: AppRoutes.product,
//         builder: (context, state) => const ProductsView(),
//       ),
//       GoRoute(
//         path: AppRoutes.prouductsCategory,
//         builder: (context, state) => const ProductsCategoryView(),
//       ),
//     ],
//   );
// }
