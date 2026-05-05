import 'package:flutter/material.dart';
import 'package:order_management_app/Models/order_model.dart';

class StatusBadgeWidget extends StatelessWidget {
  const StatusBadgeWidget({super.key, required this.status});
  final OrderStatus status;
  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(status.name.toString()));
  }
}
