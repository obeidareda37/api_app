import 'package:api_app/model/single_product_model.dart';
import 'package:api_app/provider/api_provider.dart';
import 'package:api_app/service/route_helpers.dart';
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(15),
            topEnd: Radius.circular(15),
          ),
          color: Colors.white,
        ),
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(start: 30, top: 25),
                  child: Text(
                    'Total',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(end: 30, top: 25),
                  child: Text(
                    '\$ $totalPrice',
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.orange,
                onPressed: () {},
                child: Text(
                  'Checkout',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.black),
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
                  child: Text('No Carts'),
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
                                            child: Text(
                                              '\$ ${products[index].price.toString()}',
                                              style: TextStyle(
                                                  color: Colors.deepOrange),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100,
                                          ),
                                          Container(
                                            child: Text(
                                              'quantity : ${products[index].quantity}',
                                              style: TextStyle(
                                                  color: Colors.deepOrange),
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
