import 'package:chatgpt_app/services/tasks_service.dart';
import 'package:flutter/cupertino.dart';

class TasksProvider with ChangeNotifier {
  String currentTask = "generate text";

  String get getCurrentTask {
    print('currentTask in getCurrentTask method:');
    print(currentTask);

    return currentTask;
  }

  void setCurrentTask(String newTask) {
    currentTask = newTask;
    print(currentTask);

    notifyListeners();
    print(getCurrentTask);
  }

  List<dynamic> tasksList = [];

  List<dynamic> get getTasksList {
    return tasksList;
  }

  List<dynamic> getAllTasks() {
    tasksList = TasksService.getTasks();
    return tasksList;
  }
}