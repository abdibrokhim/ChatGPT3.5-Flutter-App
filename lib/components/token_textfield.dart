import 'package:flutter/material.dart';
import 'package:chatgpt_app/constants/constants.dart';


class TokenTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;

  const TokenTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.text,
        child: TextField(
          style: const TextStyle(
            color: Colors.white,
          ),
          controller: controller,
          obscureText: obscureText,
          cursorColor: Colors.grey[500],
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: controller.clear,
              icon: const Icon(
                Icons.clear, 
                color: Colors.grey
              ),
            ),
            contentPadding: const EdgeInsets.all(20.0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: cardColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: cardColor),
            ),
            fillColor: cardColor,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey[500]
            ),
          ),
        ),
      ),
    );
  }
}