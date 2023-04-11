import 'package:flutter/material.dart';

class FeedbackTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;

  const FeedbackTextField({
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
          controller: controller,
          obscureText: obscureText,
          cursorColor: Colors.black45,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(20.0),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white60),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white60),
            ),
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])),
        ),
      ),
    );
  }
}
