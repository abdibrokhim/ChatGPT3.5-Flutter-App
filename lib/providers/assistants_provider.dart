import 'package:chatgpt_app/services/assistant_service.dart';
import 'package:flutter/cupertino.dart';

class AssistantsProvider with ChangeNotifier {
  String currentAssistant = "Assistant";

  String get getCurrentAssistant {
    print('currentAssistant in getCurrentAssistant method:');
    print(currentAssistant);

    return currentAssistant;
  }

  void setCurrentAssistant(String newAssistant) {
    currentAssistant = newAssistant;
    print(currentAssistant);
    notifyListeners();
    print(getCurrentAssistant);
  }

  List<dynamic> assistantsList = [];

  List<dynamic> get getAssistantsList {
    return assistantsList;
  }

  List<dynamic> getAllAssistants() {
    assistantsList = AssistantService.getAssistants();
    return assistantsList;
  }
}