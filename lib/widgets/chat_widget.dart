import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatgpt_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:chatgpt_app/services/services.dart';
import 'package:chatgpt_app/services/feedback.dart';


import 'text_widget.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget(
      {super.key,
      required this.msg,
      required this.chatIndex,
      this.shouldAnimate = false});

  final String msg;
  final int chatIndex;
  final bool shouldAnimate;
  
  final String lycheeIcon = "images/lycheeIcon.png";
  final String userIcon = "images/userIcon.png";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0 ? scaffoldBackgroundColor : cardColor,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image.asset(
                //   chatIndex == 0
                //   ? userIcon
                //   : lycheeIcon,
                //   width: 40,
                //   height: 40,
                // ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: chatIndex == 0
                      ? TextWidget(
                          label: msg,
                        )
                      : shouldAnimate
                          ? DefaultTextStyle(
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16
                              ),
                              child: AnimatedTextKit(
                                  isRepeatingAnimation: false,
                                  repeatForever: false,
                                  displayFullTextOnTap: true,
                                  totalRepeatCount: 1,
                                  animatedTexts: [
                                    TyperAnimatedText(
                                      msg.trim(),
                                    ),
                                  ]),
                            )
                          : Text(
                              msg.trim(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            ),
                ),
                const SizedBox(
                  width: 5,
                ),
                chatIndex == 0
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        // children: const [
                        //   Icon(
                        //     Icons.thumb_up_alt_outlined,
                        //     color: Colors.white70,
                        //   ),
                        //   SizedBox(
                        //     width: 5,
                        //   ),
                        //   Icon(
                        //     Icons.thumb_down_alt_outlined,
                        //     color: Colors.white70,
                        //   )
                        // ],
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () async {
                              await sendFeedback(
                                context: context,
                              );
                            },
                            icon: const Icon(
                              Icons.thumb_up_alt_outlined,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () async {
                              await sendFeedback(
                                context: context,
                              );
                            },
                            icon: const Icon(
                              Icons.thumb_down_alt_outlined,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> sendFeedback({required BuildContext context}) async {
    dialogBuilder(
        context: context,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
  }
}


