import 'package:flutter/material.dart';

class TabEntity {
  final String lable;
  final IconData icon;
  final int index;

  TabEntity({required this.lable, required this.icon, required this.index});

  static List<TabEntity> getTabs() {
    return [
      TabEntity(lable: "Chats", icon: Icons.chat, index: 0),
      TabEntity(lable: "Status", icon: Icons.update, index: 1),
    ];
  }
}
