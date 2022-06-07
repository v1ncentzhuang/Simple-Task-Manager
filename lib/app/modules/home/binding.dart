import 'package:get/get.dart';
import 'package:todolist/app/data/services/storage/repository.dart';
import 'package:todolist/app/modules/home/controller.dart';

import '../../data/providers/task/provider.dart';


class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(
        taskRepository: TaskRepository(
        taskProvider: TaskProvider(),
      ),
    ),
    );
  }


}