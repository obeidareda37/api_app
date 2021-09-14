import 'package:api_app/widget/custom_button/custom_button_widget.dart';
import 'package:flutter/material.dart';

class CartBottomNavigation extends StatelessWidget {
  double totalPrice=0;

  CartBottomNavigation({this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                margin:const EdgeInsetsDirectional.only(start: 30, top: 25),
                child: Text(
                  'Total',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(end: 30, top: 25),
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
                  color: Colors.orange),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: CustomButtonWidget(
                onPressed: () {},
                text: 'Checkout',
              )),
        ],
      ),
    );
  }
}
