import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomButtonSocial extends StatelessWidget {
  final String text;
  final String imageName;
  final Function()? onPress;

  CustomButtonSocial({
    this.text = '',
    required this.imageName,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        color: Colors.grey.shade50,
      ),
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              imageName,
              width: 30, // Adjust the width as per your requirements
              height: 30, // Adjust the height as per your requirements
            ),
            const SizedBox(
              height: 90, // Adjust the width as per your requirements
            ),
            const SizedBox(
              height: 90, // Adjust the width as per your requirements
            ),
            CustomText(
              text: text,
            ),
          ],
        ),
      ),
    );
  }
}

