import 'package:api_app/model/single_product_model.dart';
import 'package:api_app/provider/api_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  static final routeName ='FavoriteScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favourite')),
      body: Consumer<ApiProvider>(
        builder: (context, provider, x) {
          List<SingleProductModel> products = provider.favouriteProducts;
          return products == null
              ? Center(
                  child: Text('No Favourites'),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        CachedNetworkImage(
                            fit: BoxFit.cover, imageUrl: products[index].image),
                        Positioned.fill(
                            child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: IconButton(
                                onPressed: () {
                                  provider
                                      .deleteFromFavourite(products[index].id);
                                },
                                icon: Icon(Icons.delete)),
                          ),
                        ))
                      ],
                    );
                  });
        },
      ),
    );
  }
}
