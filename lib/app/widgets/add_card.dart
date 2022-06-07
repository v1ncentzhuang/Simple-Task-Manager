import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todolist/app/core/utils/entensions.dart';
import 'package:todolist/app/data/models/task.dart';
import 'package:todolist/app/modules/home/controller.dart';
import 'package:todolist/app/widgets/icons.dart';

class AddCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  AddCard({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;
    return Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.all(3.0.wp),
        child: InkWell(
            onTap: () async {
              await Get.defaultDialog(
                  titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
                  radius: 5,
                  title: 'Create Folder',
                  content: Form(
                      key: homeCtrl.formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                            child: TextFormField(
                              controller: homeCtrl.editCtrl,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Name',
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  //ERROR message if there is no input name
                                  return 'Enter your folder title';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                            child: Wrap(
                            spacing: 3.0.wp,
                            children: icons
                                .map((e) => Obx(() {
                                  final index = icons.indexOf(e);
                                  return ChoiceChip(

                                    //Selection color within task
                                    selectedColor: Colors.blue[50]!,

                                    //on icon click, elevation animation
                                    pressElevation: 2,

                                    //background of icons
                                    backgroundColor: Colors.white,
                                    label: e,

                                    //checks and keeps track of selected icon within app/background
                                    selected: homeCtrl.chipIndex.value == index,
                                    onSelected: (bool selected) {
                                        homeCtrl.chipIndex.value =
                                            selected ? index : 0;
                                  },
                                  );
                                }
                            )).toList()
                          ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary:Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              minimumSize: const Size(150, 40),
                            ),
                              onPressed: () {
                              if (homeCtrl.formKey.currentState!.validate()) {
                                int icon = icons[homeCtrl.chipIndex.value].icon!.codePoint;
                                String color = icons[homeCtrl.chipIndex.value].color!.toHex();
                                var task = Task(
                                  title: homeCtrl.editCtrl.text,
                                  icon: icon,
                                  color: color
                                );
                                Get.back();
                                homeCtrl.addTask(task) ?
                                EasyLoading.showSuccess('Folder Created') :
                                EasyLoading.showError('Duplicate Folder');
                              }
                              },
                              child: const Text('Create'))
                        ],
                      )
                  )
              );
              homeCtrl.editCtrl.clear();
              homeCtrl.changeChipIndex(0);
            },

            //home page dotted border + icon
            child: DottedBorder(
                color: Colors.blueGrey[400]!,
                dashPattern: const[8, 4],
                child: Center(
                    child: Icon(Icons.add,
                  size: 10.0.wp,
                  color: Colors.blueGrey,
                )))));
  }
}
