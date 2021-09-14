import 'package:api_app/provider/api_provider.dart';
import 'package:api_app/service/route_helpers.dart';
import 'package:api_app/views/home_screens/cart_screen.dart';
import 'package:api_app/widget/bottoms_navigation/details_bottom_navigation.dart';
import 'package:api_app/widget/custom_button/custom_button_widget.dart';
import 'package:api_app/widget/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  static final routeName = 'ProductDetails';

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: Consumer<ApiProvider>(
        builder: (context, provider, x) {
          return DetailsBottomNavigation(
            onPressedCart: () {
              provider.insertToCart(provider.selectedProduct);
            },
            onPressedFavorite: () {
              provider.insertToFavourite(provider.selectedProduct);
            },
          );
        },
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
        actions: [
          IconButton(
            onPressed: () {
              RouteHelper.routeHelper.goToPageReplacement(CartScreen.routeName);
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 8,
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        title: CustomText(
          text: 'Product Details',
          colorText: Colors.black,
        ),
        centerTitle: true,
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
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        child: CachedNetworkImage(
                            imageUrl: provider.selectedProduct.image),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  provider.insertToFavourite(
                                      provider.selectedProduct);
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomText(
                                        text:
                                            '${provider.selectedProduct.title}',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        colorText: Colors.deepOrange,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomText(
                                text: '${provider.selectedProduct.description}',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                colorText: Colors.black87,
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: CustomText(
                                        text:
                                            '\$ ${provider.selectedProduct.price.toString()} ',
                                        fontSize: 20,
                                        colorText: Colors.redAccent,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.orangeAccent,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        CustomText(
                                          text:
                                              '${provider.selectedProduct.rating.rate}',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        CustomText(
                                            text:
                                                '(${provider.selectedProduct.rating.count} Reviews)'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
