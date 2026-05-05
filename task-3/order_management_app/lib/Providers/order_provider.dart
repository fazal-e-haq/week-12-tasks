import 'package:flutter/material.dart';
import 'package:order_management_app/Models/order_model.dart';
import 'package:order_management_app/Services/firestore_service.dart';

class OrderProvider extends ChangeNotifier {
  final service = FirestoreService();
  List<OrderModel> orders = [];
  bool loading = false;

  Future<void> fetchOrders() async {
    loading = true;
    notifyListeners();
    orders = await service.fetchOrder();
    loading = false;
    notifyListeners();
  }

  Future<void> canceledOrder(OrderModel order) async {
    if (order.status == OrderStatus.delivered || order.status == OrderStatus.shipped) {
      throw Exception('cannot cancel this order');
    }
    await service.cencelOrder(order.id);

  }
}
