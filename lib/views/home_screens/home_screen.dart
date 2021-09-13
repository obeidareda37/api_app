import 'dart:ui';
import 'package:api_app/provider/api_provider.dart';
import 'package:api_app/service/route_helpers.dart';
import 'package:api_app/views/details/product_details.dart';
import 'package:api_app/views/home_screens/cart_screen.dart';
import 'package:api_app/views/home_screens/favorite_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        // bottomNavigationBar: BottomNavigationBar,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.grey[100],
          actions: [
            IconButton(
              onPressed: () {
                RouteHelper.routeHelper.goToPage(FavoriteScreen.routeName);
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                RouteHelper.routeHelper.goToPage(CartScreen.routeName);
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
            ),
          ],
        ),
        drawer: Drawer(
            elevation: 0,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    height: 320,
                    width: 250,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage('assets/images/logo.jpg'))),
                  ),
                  Divider(
                    indent: 10,
                    endIndent: 10,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    onTap: () {
                      RouteHelper.routeHelper
                          .goToPageReplacement(FavoriteScreen.routeName);
                    },
                    leading: Icon(
                      Icons.favorite,
                      color: Colors.black45,
                    ),
                    title: Text('Favorite Page'),
                  ),
                  ListTile(
                    onTap: () {
                      RouteHelper.routeHelper
                          .goToPageReplacement(CartScreen.routeName);
                    },
                    leading: Icon(
                      Icons.shopping_cart,
                      color: Colors.black45,
                    ),
                    title: Text('Cart Page'),
                  ),
                ],
              ),
            )),
        backgroundColor: Colors.grey[100],
        body: Consumer<ApiProvider>(
          builder: (context, provider, x) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  height: 155,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/bannar.jpg'),
                  )),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(start: 15),
                  child: Text(
                    'Categories!',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 70,
                  child: provider.allCategories == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: provider.allCategories
                                .map((e) => GestureDetector(
                                      onTap: () {
                                        provider.getCategoryProducts(e);
                                      },
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 15),
                                        decoration: BoxDecoration(
                                            color:
                                                provider.selectedCategory == e
                                                    ? Colors.deepOrangeAccent
                                                    : Colors.grey[100],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                            e[0].toUpperCase() + e.substring(1),
                                            style: TextStyle(
                                                fontSize: 20,
                                                color:
                                                    provider.selectedCategory ==
                                                            e
                                                        ? Colors.white
                                                        : Colors.black)),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                ),
                Flexible(
                  child: provider.categoryProducts == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisExtent: 200,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              itemCount: provider.categoryProducts.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    provider.getSpecificProduct(
                                        provider.categoryProducts[index].id);
                                    RouteHelper.routeHelper
                                        .goToPage(ProductDetails.routeName);
                                  },
                                  child: Container(
                                    height: 300,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional.topEnd,
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(5),
                                            width: 70,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.deepOrange,
                                              borderRadius:
                                                  BorderRadiusDirectional.only(
                                                bottomStart:
                                                    Radius.circular(15),
                                              ),
                                            ),
                                            child: Text(
                                              provider.categoryProducts[index]
                                                      .price
                                                      .toString() +
                                                  '\$',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          height: 100,
                                          padding: EdgeInsets.only(top: 2),
                                          child: CachedNetworkImage(
                                            imageUrl: provider
                                                .categoryProducts[index].image,
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(start: 10, end: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  provider
                                                      .categoryProducts[index]
                                                      .title,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      ' ${provider.categoryProducts[index].rating.rate}',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .deepOrange),
                                                    ),
                                                    Spacer(),
                                                    IconButton(
                                                        onPressed: () {
                                                          provider.insertToFavourite(
                                                              provider.categoryProducts[
                                                                  index]);
                                                          print(provider
                                                                  .categoryProducts[
                                                              index]);
                                                        },
                                                        icon: provider
                                                                    .favouriteProducts
                                                                    ?.any((element) =>
                                                                        element
                                                                            .id ==
                                                                        provider
                                                                            .categoryProducts[index]
                                                                            .id) ??
                                                                false
                                                            ? Icon(
                                                                Icons.favorite,
                                                                color: Colors
                                                                    .deepOrange,
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .favorite_border_outlined,
                                                                color: Colors
                                                                    .deepOrange,
                                                              )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                )
              ],
            );
          },
        ));
  }
}
