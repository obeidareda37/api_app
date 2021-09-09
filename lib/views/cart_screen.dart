import 'package:api_app/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<CartScreen> {
  int quantity = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ApiProvider>(context, listen: false).getProductFromCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Consumer<ApiProvider>(
        builder: (context, provider, x) {
          return provider.cartProducts == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: provider.cartProducts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.all(10),
                                    height: 100,
                                    width: 100,
                                    child: Image.network(
                                      provider.cartProducts[index].image,
                                      fit: BoxFit.contain,
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 220,
                                  child: Text(
                                    provider.cartProducts[index].title,
                                  ),
                                ),
                              ],
                            ),
                            Transform.translate(
                              offset: Offset(-15, -30),
                              child: Center(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 140),
                                  child: Text(
                                    'Price: ${provider.cartProducts[index].price}',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      provider.deleteFromCart(
                                          provider.cartProducts[index].id);
                                    });
                                  },
                                  child: Container(
                                      margin: EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.red),
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800),
                                      )),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                      width: 130,
                                      margin: EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.blueAccent),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                quantity++;
                                              });
                                            },
                                            child: Container(
                                              child: Text(
                                                '+1',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              '$quantity',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (quantity > 0) {
                                                  quantity--;
                                                } else {
                                                  quantity = 0;
                                                }
                                              });
                                            },
                                            child: Container(
                                              child: Text(
                                                '-1',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
        },
      ),
    );
  }
}
