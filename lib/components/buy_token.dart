import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';


Future<void> buyTokenDialogBuilder({
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
              backgroundColor: const Color(0xFF444654),
              title: const SizedBox.shrink(),
              content: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Contact Us",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0, 
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    ElevatedButton(
                      onPressed: _launchTelegram,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF343541),
                      ),
                      child: const Text(
                        TELEGRAM,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0, 
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                      onPressed: _launchEmail,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF343541),
                      ),
                      child: const Text(
                        EMAIL,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0, 
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}


Future<void> _launchTelegram() async {
  if (!await launchUrl(Uri.parse(TELEGRAM))) {
    throw Exception('Could not launch $TELEGRAM');
  }
}


Future<void> _launchEmail() async {
  if (!await launchUrl(Uri.parse('mailto:$EMAIL'))) {
    throw Exception('Could not launch $EMAIL');
  }
}



