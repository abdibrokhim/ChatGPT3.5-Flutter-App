import 'package:chatgpt_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'package:chatgpt_app/providers/assistants_provider.dart';
import 'package:provider/provider.dart';

class AssistantDrowDownWidget extends StatefulWidget {
  const AssistantDrowDownWidget({super.key});

  @override
  State<AssistantDrowDownWidget> createState() => _AssistantDrowDownWidgetState();
}

class _AssistantDrowDownWidgetState extends State<AssistantDrowDownWidget> {
  String? currentAssistant;

  @override
  void initState() {
    super.initState();
    currentAssistant = "Assistant";
    Provider.of<AssistantsProvider>(context, listen: false).getAllAssistants();
  }

  @override
  Widget build(BuildContext context) {
    final assistantsProvider = Provider.of<AssistantsProvider>(context);
    currentAssistant = assistantsProvider.getCurrentAssistant;
    return FittedBox(
      child: DropdownButton(
        dropdownColor: scaffoldBackgroundColor,
        iconEnabledColor: Colors.white,
        items: List<DropdownMenuItem<String>>.generate(
          assistantsProvider.getAssistantsList.length,
          (index) => DropdownMenuItem(
            value: assistantsProvider.getAssistantsList[index],
            child: TextWidget(
              label: assistantsProvider.getAssistantsList[index],
              fontSize: 15,
            ),
          ),
        ),
        value: currentAssistant,
        onChanged: (value) {
          setState(() {
            currentAssistant = value.toString();
          });
          assistantsProvider.setCurrentAssistant(
            value.toString(),
          );
        },
      ),
    );
  }
}

