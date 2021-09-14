import 'package:api_app/widget/custom_button/custom_button_widget.dart';
import 'package:flutter/material.dart';

class DetailsBottomNavigation extends StatelessWidget {
  Function onPressedCart;
  Function onPressedFavorite;


  DetailsBottomNavigation({this.onPressedCart, this.onPressedFavorite});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Row(
        children: [
          Expanded(
            child: Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.orange),
                width: double.infinity,
                child: CustomButtonWidget(
                  onPressed: () {
                    onPressedCart();
                  },
                  text: 'Add To Cart',
                )),
          ),
          GestureDetector(
            onTap: () {
              onPressedFavorite();
            },
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                Icons.favorite_border,
                size: 25,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
