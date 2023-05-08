import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../widgets/drop_down.dart';
import '../widgets/assistant_drop_down.dart';
import '../widgets/text_widget.dart';
import '../widgets/tasks_widget.dart';

class Services {
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
                padding: const EdgeInsets.all(24.0),
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
                padding: const EdgeInsets.all(24.0),
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
                padding: const EdgeInsets.all(24.0),
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
            ]
          );
        });
  }
}
