import 'package:e_commerce/routes/app_routes.dart';
import 'package:flutter/material.dart';


void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig:AppRoutes. router,
      debugShowCheckedModeBanner: false,
    );
  }
}