import 'package:api_app/model/single_product_model.dart';
import 'package:api_app/provider/api_provider.dart';
import 'package:api_app/service/route_helpers.dart';
import 'package:api_app/views/details/product_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  static final routeName = 'FavoriteScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      appBar: AppBar(
        title: Text('Favourite',style: TextStyle(color: Colors.black),),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leadingWidth: 60,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            RouteHelper.routeHelper.back();
          },
        ),
        centerTitle: true,
      ),
      body: Consumer<ApiProvider>(
        builder: (context, provider, x) {
          List<SingleProductModel> products = provider.favouriteProducts;
          return products == null
              ? Center(
                  child: Text('No Favourites'),
                )
              : Container(
            margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 220,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemCount: provider.favouriteProducts.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          provider.getSpecificProduct(
                              provider.favouriteProducts[index].id);
                          RouteHelper.routeHelper
                              .goToPage(ProductDetails.routeName);
                        },
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.only(
                                topStart: Radius.circular(15),
                                bottomStart: Radius.circular(15),
                                bottomEnd: Radius.circular(15)),
                          ),
                          child: Container(
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.topEnd,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(5),
                                    width: 70,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.deepOrange,
                                      borderRadius: BorderRadiusDirectional.only(
                                        bottomStart: Radius.circular(15),
                                      ),
                                    ),
                                    child: Text(
                                      provider.favouriteProducts[index].price
                                              .toString() +
                                          '\$',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  height: 100,
                                  padding: EdgeInsets.only(top: 2),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        provider.favouriteProducts[index].image,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 10, end: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          provider.favouriteProducts[index].title,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  provider.insertToFavourite(
                                                      provider.favouriteProducts[
                                                          index]);
                                                  print(provider
                                                      .favouriteProducts[index]);
                                                },
                                                icon: provider.favouriteProducts
                                                            ?.any((element) =>
                                                                element.id ==
                                                                provider
                                                                    .favouriteProducts[
                                                                        index]
                                                                    .id) ??
                                                        false
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          provider.deleteFromFavourite(
                                                              provider
                                                                  .favouriteProducts[
                                                                      index]
                                                                  .id);
                                                        },
                                                        child: Icon(
                                                          Icons.favorite,
                                                          color:
                                                              Colors.deepOrange,
                                                        ),
                                                      )
                                                    : Container()),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
        },
      ),
    );
  }
}
