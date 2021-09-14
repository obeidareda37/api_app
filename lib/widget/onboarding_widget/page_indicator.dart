import 'package:flutter/material.dart';

class buildPageIndicator extends StatelessWidget {
  final bool isCurrentPage;

  buildPageIndicator(this.isCurrentPage);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 35),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 15,
      width: 15,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.deepOrange : Colors.white54,
        border: isCurrentPage
            ? Border.all(
          color: Colors.deepOrange,
        )
            : Border.all(
          color: Color(0xff272727),
        ),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}