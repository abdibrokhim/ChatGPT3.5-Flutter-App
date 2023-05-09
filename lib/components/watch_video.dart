import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../constants/constants.dart';


Future<void> watchVideoDialogBuilder({
  required BuildContext context,
  required VoidCallback loadRewardedAd,
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
              backgroundColor: const Color(0xFF343541),
              title: const SizedBox.shrink(),
              content: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Watch 5 seconds video",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0, 
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    ElevatedButton(
                      onPressed: loadRewardedAd,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF444654),
                        padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                      ),
                      child: const Text(
                        "Watch Video",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0, 
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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

