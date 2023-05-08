import 'package:chatgpt_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'package:chatgpt_app/providers/tasks_provider.dart';
import 'package:provider/provider.dart';

class TasksDrowDownWidget extends StatefulWidget {
  const TasksDrowDownWidget({super.key});

  @override
  State<TasksDrowDownWidget> createState() => _TasksDrowDownWidgetState();
}

class _TasksDrowDownWidgetState extends State<TasksDrowDownWidget> {
  String? currentTask;

  @override
  void initState() {
    super.initState();
    currentTask = "generate text";
    
    Provider.of<TasksProvider>(context, listen: false).getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    currentTask = tasksProvider.getCurrentTask;
    return FittedBox(
      child: DropdownButton(
        dropdownColor: scaffoldBackgroundColor,
        iconEnabledColor: Colors.white,
        items: List<DropdownMenuItem<String>>.generate(
          tasksProvider.getTasksList.length,
          (index) => DropdownMenuItem(
            value: tasksProvider.getTasksList[index],
            child: TextWidget(
              label: tasksProvider.getTasksList[index],
              fontSize: 15,
            ),
          ),
        ),
        value: currentTask,
        onChanged: (value) {
          setState(() {
            currentTask = value.toString();
          });
          tasksProvider.setCurrentTask(
            value.toString(),
          );
        },
      ),
    );
  }
}

