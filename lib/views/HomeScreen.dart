import 'package:api_app/helpers/api_helper.dart';
import 'package:api_app/model/single_product_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            print('start');
            // List<SingleProductModel> products =
            //     await ApiHelper.apiHelper.getAllProducts();
            // print(products);
            SingleProductModel product =
                await ApiHelper.apiHelper.getSpecificProduct(1);
            print(product);
          },
        ),
      ),
    );
  }
}
