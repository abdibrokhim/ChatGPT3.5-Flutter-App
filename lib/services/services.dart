import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../widgets/drop_down.dart';
import '../widgets/assistant_drop_down.dart';
import '../widgets/text_widget.dart';
import '../widgets/tasks_widget.dart';
import 'package:chatgpt_app/components/token_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chatgpt_app/components/custom_button.dart';
import 'package:chatgpt_app/components/buy_token.dart';

import 'package:chatgpt_app/screens/chat_screen.dart';


class Services {
  static final _formKey = GlobalKey<FormState>();
  static final _tokenController = TextEditingController();

  static final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static Future<void> showModalSheet({required BuildContext context}) async {

    await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        backgroundColor: scaffoldBackgroundColor,
        context: context,
        builder: (context) {
          return Column(
            children: [
               Container(
                padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Flexible(
                      flex: 2, 
                      child: Form(
                        key: _formKey,
                        child: TokenTextField(
                          controller: _tokenController,
                          hintText: "Enter your token here",
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'PleaseEnter your token';
                            } 
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Flexible(
                      child: TextWidget(
                        label: "Chosen Model:",
                        fontSize: 16,
                      ),
                    ),
                    Flexible(flex: 2, child: ModelsDrowDownWidget()),
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Flexible(
                      child: TextWidget(
                        label: "Chosen Assistant:",
                        fontSize: 16,
                      ),
                    ),
                    Flexible(child: AssistantDrowDownWidget()),
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Flexible(
                      child: TextWidget(
                        label: "Chosen Task:",
                        fontSize: 16,
                      ),
                    ),
                    Flexible(child: TasksDrowDownWidget()),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(24, 36, 24, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Flexible(
                      child: TextWidget(
                        label: "Buy API Key or Watch 5 second video to get free API Key:",
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: CustomButton(
                        buttonName: 'Buy API Key',
                        buttonColor: cardColor,
                        onTap: () async {
                          await onBuyTokenClick(context: context);
                        },
                      ),
                    ),
                    Flexible(
                      child: CustomButton(
                        buttonName: 'Watch Video',
                        buttonColor: cardColor,
                        onTap: () async {
                          await onWatchVideoClick(context: context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ]
          );
        });

    await saveToken();

  }

  static Future<void> saveToken() async {

    final SharedPreferences prefs = await _prefs;

    prefs.setString('apikey', _tokenController.text);

    print('prefs.getString(\'apikey\'):');
    print(prefs.getString('apikey'));

  }

  static Future<void> onBuyTokenClick({required BuildContext context}) async {
    buyTokenDialogBuilder(
      context: context,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }


  static Future<void> onWatchVideoClick({required BuildContext context}) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('loadrewardedad', true);
    
    
    print('prefs.getBool(\'loadrewardedad\'):');
    print(prefs.getBool('loadrewardedad'));
  }

}
