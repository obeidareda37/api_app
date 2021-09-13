import 'package:api_app/model/single_product_model.dart';
import 'package:api_app/provider/api_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static final routeName ='CartScreen';

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: Consumer<ApiProvider>(
        builder: (context, provider, x) {
          List<SingleProductModel> products = provider.cartProducts;
          return products == null
              ? Center(
                  child: Text('No Carts'),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(5),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: CachedNetworkImage(
                              imageUrl: products[index].image,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(products[index].title),
                              Row(
                                children: [
                                  Text('Price: ' +
                                      products[index].price.toString() +
                                      '\$'),
                                  Spacer(),
                                  Text('Quantity: ' +
                                      products[index].quantity.toString())
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
        },
      ),
    );
  }
}
