import 'package:flutter/material.dart';
import '../../constance.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function()? onPress; // Changed type to Function()?

  // Removed unnecessary comma after onPress
  CustomButton({
    this.onPress,
    this.text = 'Write text',
    this.color = primaryColor,
  });

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
      onPressed: onPress,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),

      child: CustomText(
        text: text,
        alignment: Alignment.center,
        color: Colors.white,
      ),
    );
  }
}
