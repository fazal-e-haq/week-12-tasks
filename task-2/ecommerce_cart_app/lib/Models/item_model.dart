import 'package:flutter/material.dart';

class ItemModel {
  int id;

  String itemName;
  double itemPrice;
  Icon itemIcon;

  ItemModel({
    required this.id,

    required this.itemIcon,
    required this.itemName,
    required this.itemPrice,
  });
}
