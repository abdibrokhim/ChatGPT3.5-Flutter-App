import 'dart:developer';

import 'package:chatgpt_app/constants/constants.dart';
import 'package:chatgpt_app/providers/chats_provider.dart';
import 'package:chatgpt_app/providers/assistants_provider.dart';
import 'package:chatgpt_app/providers/tasks_provider.dart';
import 'package:chatgpt_app/services/services.dart';
import 'package:chatgpt_app/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../providers/models_provider.dart';
import '../widgets/text_widget.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:chatgpt_app/ad_helper/ad_helper.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;

  late TextEditingController textEditingController;
  late ScrollController _listScrollController;
  late FocusNode focusNode;

  int _adCounter = 0;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  AppOpenAd? _appOpenAd;

  @override
  void initState() {
    _listScrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();

    // _loadAppOpenAd();

    // _loadInterstitialAd();
  }

  void _loadAppOpenAd() {
    AppOpenAd.load(
      adUnitId: AdHelper.appOpenAdUnitId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            _appOpenAd = ad;
            
            _appOpenAd?.show();
          });
        },
        onAdFailedToLoad: (err) {
          debugPrint('Failed to load an app open ad: ${err.message}');
        },
      ),
      orientation: AppOpenAd.orientationPortrait,
    );
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {

          setState(() {
            _interstitialAd = ad;
            
            _interstitialAd?.show();

          });
        },
        onAdFailedToLoad: (err) {
          debugPrint('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {

          setState(() {
            _rewardedAd = ad;

            _rewardedAd?.show(
              onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem){
                num amount = rewardItem.amount;
                debugPrint('Reward amount: $amount');
              }
            );
          });
        },
        onAdFailedToLoad: (err) {
          debugPrint('Failed to load a rewarded ad: ${err.message}');
        },
      ),
    );
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    super.dispose();
  }

  final String lycheeIcon = "images/lycheeIcon.svg";

  // List<ChatModel> chatList = [];
  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    final assistantProivder = Provider.of<AssistantsProvider>(context);
    final tasksProvider = Provider.of<TasksProvider>(context);

    
    print('tasksProvider in chat_screen.dart:');
    print(tasksProvider.getCurrentTask);


    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: Container(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          margin: const EdgeInsets.symmetric(horizontal: 0.0),
          // child: SvgPicture.asset(
          //   lycheeIcon, 
          //   semanticsLabel: 'Lychee Logo'
          // ),
        ),
        title: const Text("ChatGPT4"),
        actions: [
          IconButton(
            onPressed: () async {
              await Services.showModalSheet(context: context);
            },
            icon: const Icon(
              Icons.more_vert_rounded, 
              color: Colors.white
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                  controller: _listScrollController,
                  itemCount: chatProvider.getChatList.length, //chatList.length,
                  itemBuilder: (context, index) {
                    return ChatWidget(
                      msg: chatProvider
                          .getChatList[index].msg, // chatList[index].msg,
                      chatIndex: chatProvider.getChatList[index]
                          .chatIndex, //chatList[index].chatIndex,
                      task: tasksProvider.getCurrentTask,
                      shouldAnimate:
                          chatProvider.getChatList.length - 1 == index,
                    );
                  }),
            ),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              ),
            ],
            const SizedBox(
              height: 15,
            ),
            Material(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.text,
                        child: GestureDetector(
                          onTap: () {
                            focusNode.requestFocus();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: TextField(
                                    focusNode: focusNode,
                                    style: const TextStyle(color: Colors.white),
                                    controller: textEditingController,
                                    maxLines: null,
                                    onSubmitted: (value) async {
                                      await sendMessageFCT(
                                          modelsProvider: modelsProvider,
                                          chatProvider: chatProvider,
                                          assistantProivder: assistantProivder,
                                          tasksProvider: tasksProvider,
                                      );

                                      // if (tasksProvider.getCurrentTask == tasksList[0]) {
                                      // } else if (tasksProvider.getCurrentTask == tasksList[1]) {
                                      //   await generateImage();
                                      // } else if (tasksProvider.getCurrentTask == tasksList[2]) {
                                      //   await generateImage();
                                      // }

                                    },
                                    decoration: const InputDecoration.collapsed(
                                        hintText: "Send a message...",
                                        hintStyle: TextStyle(color: Colors.grey)),
                                  ),
                                ),
                        ),
                      ),
                    ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Transform.rotate(
                      angle: 0,
                      child: IconButton(
                        onPressed: () async {
                          await sendMessageFCT(
                              modelsProvider: modelsProvider,
                              chatProvider: chatProvider,
                              assistantProivder: assistantProivder,
                              tasksProvider: tasksProvider,
                          );
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white70,
                        ))
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scrollListToEND() {
    _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut);
  }

  Future<void> sendMessageFCT(
      {required ModelsProvider modelsProvider,
      required ChatProvider chatProvider,
      required AssistantsProvider assistantProivder,
      required TasksProvider tasksProvider
      
      }) async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "Multiple messages not allowed at a time",
          ),
          backgroundColor: Colors.red,
        ),
      );

      _adCounter++;
      _loadInterstitialAd();
      
      if (_adCounter % 2 == 0) {
        _loadRewardedAd();
        _adCounter = 0;
      }

      return;
    }
    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "Message can't be empty",
          ),
          backgroundColor: Colors.red,
        ),
      );

      _adCounter++;
      _loadInterstitialAd();

      if (_adCounter % 2 == 0) {
        _loadRewardedAd();
        _adCounter = 0;
      }

      return;
    }
    try {
      String msg = textEditingController.text;

      setState(() {
        _isTyping = true;
        // chatList.add(ChatModel(msg: textEditingController.text, chatIndex: 0));
        chatProvider.addUserMessage(msg: msg);
        textEditingController.clear();
        focusNode.unfocus();
      });
      await chatProvider.sendMessageAndGetAnswers(
          msg: msg, 
          chosenModelId: modelsProvider.getCurrentModel, 
          choosenAssistantId: assistantProivder.getCurrentAssistant, 
          choosenTask: tasksProvider.getCurrentTask
      );
      // chatList.addAll(await ApiService.sendMessage(
      //   message: textEditingController.text,
      //   modelId: modelsProvider.getCurrentModel,
      // ));
      setState(() {});
    } catch (error) {
      log("error $error");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: TextWidget(
          label: error.toString(),
        ),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        scrollListToEND();
        _isTyping = false;
        
        _loadInterstitialAd();
 
      });
    }
  }

  Future<void> generateImage() async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "Multiple messages not allowed at a time",
          ),
          backgroundColor: Colors.red,
        ),
      );

      _adCounter++;
      _loadInterstitialAd();
      
      if (_adCounter % 2 == 0) {
        _loadRewardedAd();
        _adCounter = 0;
      }

      return;
    }
    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "Message can't be empty",
          ),
          backgroundColor: Colors.red,
        ),
      );

      _adCounter++;
      _loadInterstitialAd();

      if (_adCounter % 2 == 0) {
        _loadRewardedAd();
        _adCounter = 0;
      }

      return;
    }
    try {
      String msg = textEditingController.text;

      setState(() {
        _isTyping = true;

        textEditingController.clear();
        focusNode.unfocus();
      });

      // await chatProvider.sendMessageAndGetAnswers(
          // msg: msg, chosenModelId: modelsProvider.getCurrentModel, choosenAssistantId: assistantProivder.getCurrentAssistant
      // );

      setState(() {});
    } catch (error) {
      log("error $error");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: TextWidget(
          label: error.toString(),
        ),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        scrollListToEND();
        _isTyping = false;
        
        _loadInterstitialAd();
 
      });
    }
  }
}
