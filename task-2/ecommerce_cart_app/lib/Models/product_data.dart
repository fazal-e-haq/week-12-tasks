import 'package:flutter/material.dart';

class ProductModel {
  int id;
  String name;
  double price;
  Icon icon;
  int quantity;
  ProductModel({
    required this.id,
    required this.icon,
    required this.name,
    required this.price,
    this.quantity = 1,
  });
}
