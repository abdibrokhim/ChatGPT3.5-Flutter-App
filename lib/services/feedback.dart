import 'package:flutter/material.dart';
import 'package:chatgpt_app/services/feedback_textfield.dart';

final _feedackController = TextEditingController();

Future<void> dialogBuilder({
  required BuildContext context,
  required VoidCallback onPressed,
}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {
          // Dismiss the dialog if the user taps outside of it
          Navigator.of(context).pop();
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Center(
            child: AlertDialog(
              title: const SizedBox.shrink(),
              content: FeedbackTextField(
                controller: _feedackController,
                hintText: "Enter your feedback here",
                obscureText: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Feedback cannot be empty';
                  }
                  return null;
                },
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              actions: [
                Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.bodyLarge,
                    ),
                    onPressed: onPressed,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF444654),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Text(
                        "SEND",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


