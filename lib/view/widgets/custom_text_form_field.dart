import 'package:flutter/material.dart';
import 'custom_text.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String text;
  final String hint;
  final String? Function(String?)? validator; // تم تصحيح الصيغة لمعلمات الدالة
  final void Function(String)? onChanged; // تمت إضافة استدعاء onChanged

  const CustomTextFormField({
    required this.controller,
    required this.text,
    required this.hint,
    this.validator,
    this.onChanged, // تمت إضافة استدعاء onChanged إلى البناء
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: text,
            fontSize: 14,
            color: Colors.grey.shade900,
          ),
          TextFormField(
            controller: controller, // تمت إضافة استدعاء onChanged إلى TextFormField
            onChanged: onChanged,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Colors.black,
              ),
              fillColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
