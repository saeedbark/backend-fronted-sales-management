import 'package:shopping/models/login_model.dart';

abstract class ShopLoginState {}

class ShopLoginInitialState extends ShopLoginState {}

class ShopLoginChangePageState extends ShopLoginState {}

class ShopLoginChangePasswordShowState extends ShopLoginState {}

/////////// userDataPost/////
class ShopLoginLoadingState extends ShopLoginState {}

class ShopLoginSuccessState extends ShopLoginState {
  late UserLoginModel mod;

  ShopLoginSuccessState(this.mod);
}

class ShopLoginErrorState extends ShopLoginState {
  final String error;

  ShopLoginErrorState(this.error);
}

///////////