import 'package:api_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class onBoardingWidget extends StatelessWidget {
  String title;
  String description;
  String image;

  onBoardingWidget({this.title, this.description, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 70),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image,
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: 30,
          ),
          CustomText(
            text: title,
            fontSize: 25,
            colorText: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(right: 50, left: 50),
            child: CustomText(
              text: description,
              fontSize: 17,
              maxLines: 2,
              textAlign: TextAlign.center,
              colorText: Color(0xff4D4D4D),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
