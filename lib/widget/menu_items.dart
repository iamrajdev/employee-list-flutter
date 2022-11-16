import 'package:employee_info/model/menu_item_option_model.dart';
import 'package:flutter/material.dart';

class MenuItemsModel {
  static final List<MenuItemOption> itemList = [
    logOut,
  ];

  static final logOut = MenuItemOption(
    title: 'Logout',
    icon: Icons.logout_outlined,
  );
}
