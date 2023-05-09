import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:chatgpt_app/components/custom_button.dart';
import 'package:chatgpt_app/constants/constants.dart';


class ErrorWidgetClass extends StatelessWidget {
  final FlutterErrorDetails errorDetails;
  
  const ErrorWidgetClass({super.key, required this.errorDetails});
  @override
  Widget build(BuildContext context) {
    return CustomErrorWidget(
        errorMessage: errorDetails.exceptionAsString(),
    );
  }
} 


class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;

  const CustomErrorWidget({super.key, required this.errorMessage});
  
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: const MediaQueryData(),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Material(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
            child: Card(
              elevation: 10,
              // color: Colors.white.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      LineIcons.exclamationTriangle,
                      size: 50.0,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Error Occurred!',
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 18.0, 
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      errorMessage,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 30.0),
                    const Text(
                      'Restart the App, if error occured again tap the button below and contact us',
                      style: TextStyle(
                          fontSize: 14.0, 
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    CustomButton(
                      buttonName: EMAIL,
                      buttonColor: scaffoldBackgroundColor,
                      onTap: () async {
                        await sendFeedback(context: context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendFeedback({required BuildContext context}) async {
    // TODO: implement sendFeedback
  }
}


