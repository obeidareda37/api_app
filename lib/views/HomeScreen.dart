import 'package:api_app/helpers/api_helper.dart';
import 'package:api_app/model/single_product_model.dart';
import 'package:api_app/provider/api_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Home Screen'),
        ),
        body: Consumer<ApiProvider>(
          builder: (context, provider, x) {
            return Column(
              children: [
                provider.allProducts == null
                    ? Container(
                        height: 200,
                        color: Colors.white,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container(
                        color: Colors.white,
                        height: 200,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: CarouselSlider(
                          items: provider.allProducts
                              .map((e) => CachedNetworkImage(imageUrl: e.image))
                              .toList(),
                          options: CarouselOptions(
                            height: 400,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            autoPlay: true,
                          ),
                        ),
                      )
              ],
            );
          },
        ));
  }
}
