import 'package:api_app/helpers/database_helpers.dart';
import 'package:api_app/provider/api_provider.dart';
import 'package:api_app/service/route_helpers.dart';
import 'package:api_app/views/details/product_details.dart';
import 'package:api_app/views/home_screens/cart_screen.dart';
import 'package:api_app/views/home_screens/favorite_screen.dart';
import 'package:api_app/views/home_screens/home_screen.dart';
import 'package:api_app/views/onboarding_screen/onboarding_screen.dart';
import 'package:api_app/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.databaseHelper.initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApiProvider()),
      ],
      child: MaterialApp(
        title: 'Api App',
        debugShowCheckedModeBanner: false,
        navigatorKey: RouteHelper.routeHelper.navKey,
        routes: {
          ProductDetails.routeName: (context) => ProductDetails(),
          HomeScreen.routeName: (context) => HomeScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          FavoriteScreen.routeName: (context) => FavoriteScreen(),
          OnBoardingScreen.routName: (context) => OnBoardingScreen(),
        },
        home: SplashScreen(),
      ),
    );
  }
}
