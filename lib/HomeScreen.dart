import 'package:api_app/api_helper.dart';
import 'package:api_app/single_product_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            List<SingleProductModel> products =
                await ApiHelper.apiHelper.getAllProducts();
            print(products);
          },
        ),
      ),
    );
  }
}
