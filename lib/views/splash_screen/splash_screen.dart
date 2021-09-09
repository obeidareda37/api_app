import 'package:api_app/provider/api_provider.dart';
import 'package:api_app/views/HomeScreen.dart';
import 'package:api_app/views/home_page.dart';
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
    Provider.of<ApiProvider>(context,listen: false).getAllCategories();
    Provider.of<ApiProvider>(context,listen: false).getAllProducts();

  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((value) => {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()),
          )
        });
    return Scaffold(
      body: Center(
        child: FlutterLogo(),
      ),
    );
  }
}
