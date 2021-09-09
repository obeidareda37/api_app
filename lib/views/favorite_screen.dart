import 'package:api_app/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ApiProvider>(context, listen: false).getProductFromFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite'),
      ),
      body: Consumer<ApiProvider>(
        builder: (context, provider, x) {
          return provider.favoriteProducts == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: provider.favoriteProducts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 8,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.all(10),
                                    height: 100,
                                    width: 100,
                                    child: Image.network(
                                      provider.favoriteProducts[index].image,
                                      fit: BoxFit.contain,
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 220,
                                  child: Text(
                                    provider.favoriteProducts[index].title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                   setState(() {
                                     provider.deleteFromDatabase(provider.favoriteProducts[index].id);
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
                                      margin: EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.blueAccent),
                                      child: Text(
                                        'Add To Cart',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800),
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
