import 'package:api_app/views/HomeScreen.dart';
import 'package:api_app/views/cart_screen.dart';
import 'package:api_app/views/favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> {
  int index = 0;
  List<Widget> screens = [
    HomeScreen(),
    FavoriteScreen(),
    CartScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: screens.elementAt(index),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (tapedIndex) {
          this.index = tapedIndex;
          setState(() {});
        },
        selectedItemColor: Color(0xff3797A4),
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
