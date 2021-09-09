import 'package:api_app/provider/api_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Consumer<ApiProvider>(
        builder: (context, provider, index) {
          return provider.selectedProduct == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        child: CachedNetworkImage(
                            imageUrl: provider.selectedProduct.image),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Title: ' + provider.selectedProduct.title,
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.favorite,
                                      color: provider.isFavorite
                                          ? Colors.red
                                          : Colors.grey),
                                  onPressed: () {
                                    if (provider.isFavorite == false) {
                                      print('add to database');
                                      provider.insertToFavorite();
                                    } else {
                                      print('delete from database');
                                      provider.deleteFromDatabase(
                                          provider.selectedProduct.id);
                                    }
                                  },
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                'Description: ' +
                                    provider.selectedProduct.description,
                                style: TextStyle(fontSize: 20)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                'Price: ' +
                                    provider.selectedProduct.price.toString(),
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          provider.insertToCart();
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blueAccent),
                          width: double.infinity,
                          child: Text(
                            'Add To Cart',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
