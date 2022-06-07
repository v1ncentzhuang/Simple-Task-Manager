import 'package:flutter/material.dart';
import 'package:todolist/app/core/values/colors.dart';
import 'package:todolist/app/core/values/icons.dart';

List<Icon> getIcons() {
  return const [
    Icon(IconData(personIcon, fontFamily: 'MaterialIcons'), color: pink),
    Icon(IconData(workIcon, fontFamily: 'MaterialIcons'), color: red),
    Icon(IconData(schoolIcon, fontFamily: 'MaterialIcons'), color: blue),
    Icon(IconData(shoppingIcon, fontFamily: 'MaterialIcons'), color: pink),
  ];
}