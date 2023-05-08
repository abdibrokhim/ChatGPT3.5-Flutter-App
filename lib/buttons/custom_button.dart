import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonName;
  final Color buttonColor;

  const CustomButton({
    super.key, 
    required this.onTap,
    required this.buttonName,
    required this.buttonColor,
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
          margin: const EdgeInsets.symmetric(horizontal: 25.0),
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            buttonName,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}