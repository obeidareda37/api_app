import 'package:api_app/widget/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
   Function() onPressed;

  String text;

  CustomButtonWidget({
     this.onPressed,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(25)),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      highlightElevation: 0,
      onPressed: () {
        onPressed();
      },
      child: CustomText(
        text: text,
        colorText: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }
}
