import 'package:e_commerce/shared_pref/shared_preferences.dart';
import 'package:e_commerce/src/products/products_view.dart';
import 'package:e_commerce/src/auth/login/login_view.dart';
import 'package:e_commerce/src/auth/register/register_view.dart';
import 'package:go_router/go_router.dart';


class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
}

final GoRouter router = GoRouter(
  
  initialLocation:AppRoutes.login ,
  redirect: (context, state) async{
    final token = await SharedPreferencesHelper.getString('token');
    final isAuthenticated = token != null && token.isNotEmpty;

    if (!isAuthenticated && state.location != AppRoutes.register) {
      return AppRoutes.login;
    }

    return null; 
  },
  routes: [

    GoRoute(
      path: '/',
      redirect: (context, state) => AppRoutes.login,
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
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);


Future<String?> isToken()async {
  final String? token = await SharedPreferencesHelper.getString('token');
  return token;
}