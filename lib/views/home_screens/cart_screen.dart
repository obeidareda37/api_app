import 'package:api_app/model/single_product_model.dart';
import 'package:api_app/provider/api_provider.dart';
import 'package:api_app/service/route_helpers.dart';
import 'package:api_app/widget/bottoms_navigation/cart_bottom_navigation.dart';
import 'package:api_app/widget/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartScreen extends StatefulWidget {
  static final routeName = 'CartScreen';

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double totalPrice =
        Provider.of<ApiProvider>(context, listen: false).getTotalPrice();

    return Scaffold(
      bottomNavigationBar: CartBottomNavigation(
        totalPrice: totalPrice,
      ),
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: CustomText(
          text: 'Cart',
          colorText: Colors.black,
        ),
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
          List<SingleProductModel> products = provider.cartProducts;
          return products == null
              ? Center(
                  child: CustomText(
                    text: 'No Carts',
                  ),
                )
              : Container(
                  margin: EdgeInsetsDirectional.only(top: 15, start: 5, end: 5),
                  child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actions: [
                            Transform.translate(
                              offset: Offset(5, 0),
                              child: IconSlideAction(
                                iconWidget: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                  ),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                                color: Colors.transparent,
                                onTap: () {
                                  provider.deleteFromCart(products[index].id);
                                },
                              ),
                            ),
                          ],
                          child: Container(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusDirectional.only(
                                      bottomStart: Radius.circular(15),
                                      topEnd: Radius.circular(15))),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsetsDirectional.only(
                                        top: 5, bottom: 5),
                                    height: 120,
                                    width: 120,
                                    child: CachedNetworkImage(
                                      imageUrl: products[index].image,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Text(
                                          products[index].title,
                                          maxLines: 2,
                                          style: TextStyle(fontSize: 18),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            child: CustomText(
                                              text:
                                                  '\$ ${products[index].price.toString()}',
                                              colorText: Colors.deepOrange,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100,
                                          ),
                                          Container(
                                            child: CustomText(
                                              text:
                                                  'quantity : ${products[index].quantity}',
                                              colorText: Colors.deepOrange,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
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
