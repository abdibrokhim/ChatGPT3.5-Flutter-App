import 'package:flutter/cupertino.dart';

import '../models/chat_model.dart';
import '../services/api_service.dart';

import 'package:chatgpt_app/constants/constants.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList {
    return chatList;
  }

  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers(
      {required String msg, required String chosenModelId, required String choosenAssistantId, required String choosenTask}) async {
        if(choosenTask == tasksList[1]) {
          chatList.addAll(await ApiService.sendMessageToGenerateImage(
            message: msg,
          ));

          notifyListeners();

        } else {
          if (chosenModelId.toLowerCase().startsWith("gpt")) {
            chatList.addAll(await ApiService.sendMessageGPT(
              message: msg,
              modelId: chosenModelId,
              assistantId: choosenAssistantId,
            ));
          } else {
            chatList.addAll(await ApiService.sendMessage(
              message: msg,
              modelId: chosenModelId,
            ));
          }
          notifyListeners();
        }
  }
}
