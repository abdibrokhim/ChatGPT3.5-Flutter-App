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

import 'package:shared_preferences/shared_preferences.dart';
import 'package:chatgpt_app/components/watch_video.dart';
import 'package:chatgpt_app/components/preview_info.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();

}

class _ChatScreenState extends State<ChatScreen> {
  static final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool _isTyping = false;

  late TextEditingController textEditingController;
  late ScrollController _listScrollController;
  late FocusNode focusNode;
  bool appOpened = false;

  int _requestCounter = 0;
  int videoLimit = 3;

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

    _loadAppOpenAd();

    _loadInterstitialAd();
    
  }



  void startRewardedVideo() async {
    final SharedPreferences prefs = await _prefs;
    
    prefs.getBool('loadrewardedad') ?? true ? _loadRewardedAd() : null;
  }


  void _loadAppOpenAd() async {
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

    appOpened = true;
    
    final SharedPreferences prefs = await _prefs;

    prefs.setBool('loadrewardedad', false);
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

  void _loadRewardedAd() async {
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
    
    _requestCounter = 0;

    await stopRewardedAd();

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
        ),
        title: const Text("ChatGPT4"),
        actions: [
          IconButton(
            onPressed: () async {
              chatProvider.clearChatList();
            },
            icon: const Icon(
              Icons.add, 
              color: Colors.white
            ),
          ),
          IconButton(
            onPressed: () async {
              await Services.showModalSheet(context: context);
              startRewardedVideo();
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
            chatProvider.chatList.isNotEmpty
            ? Flexible(
              child: ListView.builder(
                  controller: _listScrollController,
                  itemCount: chatProvider.getChatList.length,
                  itemBuilder: (context, index) {
                    return ChatWidget(
                      msg: chatProvider
                          .getChatList[index].msg,
                      chatIndex: chatProvider.getChatList[index]
                          .chatIndex,
                      task: tasksProvider.getCurrentTask,
                      shouldAnimate:
                          chatProvider.getChatList.length - 1 == index,
                    );
                  }),
            )
            : const Flexible(
              child: PreviewInfo(),
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

  static Future<void> stopRewardedAd() async {

    final SharedPreferences prefs = await _prefs;

    prefs.setBool('loadrewardedad', false);

    print('prefs.getBool(\'loadrewardedad\'):');
    print(prefs.getBool('loadrewardedad'));

  }

  static Future<String> getApiKey() async {

    final SharedPreferences prefs = await _prefs;

    String apiKey = prefs.getString('apikey') ?? '';

    return apiKey;

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

    Future<String> apiKey;
    apiKey = getApiKey();

    print('apiKey=$apiKey');

    if (_requestCounter > videoLimit) {

      print('loading rewarded ad _requestCounter=$_requestCounter');

      watchVideoDialogBuilder(
        context: context,
        loadRewardedAd: _loadRewardedAd,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      
      return;
    }

    try {
      String msg = textEditingController.text;

      setState(() {
        _isTyping = true;
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

        _requestCounter++;

        print('_requestCounter=$_requestCounter');
 
      });
    }
  }
}
