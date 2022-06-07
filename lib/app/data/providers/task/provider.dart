import 'dart:convert';

import 'package:get/get.dart';
import 'package:todolist/app/core/utils/keys.dart';
import 'package:todolist/app/data/models/task.dart';
import 'package:todolist/app/data/services/storage/services.dart';


class TaskProvider {
  StorageService _storage = Get.find<StorageService>();

//   {
//     'tasks': [
//   {
//     'title': 'Work',
//   'color': '#ff123456',
//   'icon': 0xe123
//   }
//     ]
// }

  Future<List<Task>> readTasks() async {
    var tasks = <Task>[];
    jsonDecode(_storage.read(taskKey).toString())
      .forEach((e) => tasks.add(Task.fromJson(e)));
    return tasks;
  }

  void writeTasks(List<Task> tasks) {
    _storage.write(taskKey, jsonEncode(tasks));
  }
}