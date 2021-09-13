import 'package:api_app/provider/api_provider.dart';
import 'package:api_app/service/route_helpers.dart';
import 'package:api_app/views/home_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ApiProvider>(context, listen: false).getAllCategories();
    Provider.of<ApiProvider>(context, listen: false).getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((value) => {
          RouteHelper.routeHelper.goToPageReplacement(HomeScreen.routeName),
        });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Container(
            width: 260,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage('assets/images/logo.jpg'),
          ),
        ),
      )),
    );
  }
}
